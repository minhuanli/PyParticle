;;; density of states
;;; packaged programs using matrices

pro DOS, otra, lifetime=lifetime, cov=cov,eigen=eigen,smp=smp, bri=bri, mass1=mass1,ev=ev
;; convert track to a displacement matrix, not weighted
;; calculate the correlation between displacements
;; calculate the eigen values from correlation matrix
;; otra is the track file, lifetime is the number of frames the particle needs to be
;; to be included in the calculation (short lifetime messes up correlation, choose at least 90% of your number of frames),
;; sm is the smooth factor in the remove motion (drfiting creats false correlations)
;; insufficient statistics may result in the failure of solving the matrix
;; if only the modes are needed run this function directly
;; if you need some intermediate results, positions, matrix, vector... uncomment certain lines and save them
;; I kept the weighted lines commented, as it is a issue remains to be worked out theoretically,
;;   though the results should not be quite different

if not keyword_set(smp) then smp=10
if not keyword_set(bri) then bri=0.0
if not keyword_set(mass1) then mass1=1.0

;if smp ne 0 then begin
;  mot=motion(otra)
;  tra=rm_motion(otra, mot, smooth=smp) ;; remove drifting
;  otra=0                              ;; clear original track
;endif else begin
  tra=otra
  ;otra=0
;endelse

 ncol=n_elements(tra(*,0))
 xcol=0
 ycol=1
 bcol=2   ;; brightness column if needed
 idcol=ncol-1
 timecol=ncol-2
npart=max(tra(idcol, *))+1 ; number of particles
maxtime=max(tra(timecol,*))+1 ; longest time

traend=n_elements(tra(idcol,*)) ; the last index of the trackfile plus one
ididx=tra(idcol,*)
ididx=ididx-shift(ididx,1)
wp=where(ididx(*) ne 0.0,nwp)
wp=[wp, traend]  ;; the ith particle is between wp(i) and wp(i+1)-1

counter=0
temp=fltarr(npart*2, maxtime) ; twice the x size for both x and y directions--memory intensive!!
table=fltarr(3, npart*2)      ;; position table if needed, x0...xn, y0...yn
weight=1.0

;for i=0, nwp-1 do begin;npart-1 do begin change by PJY
for i=0, npart-1 do begin ;change by PJY
	life=wp(i+1)-wp(i)-1
	if life ge lifetime then begin

    ;    if mean(tra(bcol,wp(i):wp(i+1)-1)) gt bri then table(2,counter)=mass1 else table(2,counter)=1.0
    table(2,counter)=mean(tra(bcol,wp(i):wp(i+1)-1))
    weight=table(2,counter)
    time=tra(timecol, wp(i):wp(i+1)-1)
    avg=mean(tra(xcol,wp(i):wp(i+1)-1))
		temp(counter, round(time))=(tra(xcol,wp(i):wp(i+1)-1)-avg)
        table(0,counter)=counter
		table(1,counter)=avg
	    counter=counter+1
	endif
endfor

;for i=0, nwp-1 do begin;npart-1 do begin change by PJY
for i=0, npart-1 do begin ;change by PJY
	life=wp(i+1)-wp(i)-1
	if life ge lifetime then begin
     ;   if mean(tra(bcol,wp(i):wp(i+1)-1)) gt bri then table(2,counter)=mass1 else table(2,counter)=1.0
      table(2,counter)=mean(tra(bcol,wp(i):wp(i+1)-1))
        weight=table(2,counter)
	time=tra(timecol, wp(i):wp(i+1)-1)
    avg=mean(tra(ycol,wp(i):wp(i+1)-1))
	temp(counter, round(time))=(tra(ycol,wp(i):wp(i+1)-1)-avg)
    table(0,counter)=counter
	table(1,counter)=avg
    counter=counter+1
	endif
endfor

;;if you need the position table save it here
;;write_text, table, 'tablename.txt'
;table=table(*,counter-1)
;print,counter
;write_text, table, 'X0XnY0Yn.txt'

dmx=temp(0:counter-1,*)  ;; displacment matrix
;write_text, dmx, 'disp_X0XnY0Yn.txt'
dcmx=correlate(dmx,/covariance)      ;; construct displacement correlation matrix-memory and cpu intensive
write_gdf, dcmx, 'disp.gdf'
cov=dcmx
inv=invert(dcmx)
;dcmx=0
inv=(inv+transpose(inv))/2.0
;write_text, inv, 'km.txt'


;m=fltarr(counter)
;m(*)=table(2,0:counter-1)
;mmask=m#m
;mmask=sqrt(mmask)
;inv=inv/mmask
;inv=(inv+transpose(inv))/2.0

;for i=0,counter-1 do inv(i,*)=inv(i,*)/table(2,i)
;inv=(inv+transpose(inv))/2.0

;write_text,inv,'km_mi.txt'

if not keyword_set(ev) then eigen=eigenql(float(inv)) else begin
  eigen=la_eigenql(float(inv), eigenvectors=egv)  ;; will increases memory usage
  ;write_gdf, egv, 'eigenvectors.gdf'      ;; the same size as the matrix
endelse
eigen=eigen
;return, eigen
end

