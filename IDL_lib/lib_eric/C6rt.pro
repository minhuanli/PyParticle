;C6rt=<\psi(r,t)psi*(0,0)> eq.2.222 in David Nelson's book
;trkbond:[x of bond center, y, angle, time, track#]
;rbinsize: better resolutio should not increase computing time
;rrange:range of C_6(r)
;trange:time range of C_6(t)
;outfile: [0,*,*] C6rt, real part should almost same as abs; [1,*,*] weights
pro C6rt,trkbond,outfile,rrange=rrange,trange=trange,mydts=mydts,rbinsize=rbinsize

w=max(trkbond[0,*])-min(trkbond[0,*])
h=max(trkbond[1,*])-min(trkbond[1,*])
if not keyword_set(rrange) then rrange=sqrt(w^2+h^2)
if not keyword_set(trange) then trange=max(trkbond[3,*])-2
if not keyword_set(rbinsize) then rbinsize=1

if not keyword_set(mydts) then begin
; generate the time partition-- about 10 points per decade
	dt = round(1.15^findgen(100))
	dt = dt(uniq(dt))
	w = where( dt le round(trange), ndt )
	dt = dt(w)
endif else begin
	dt = mydts
	ndt = n_elements(dt)
endelse

res=complexarr(2,rrange/rbinsize,ndt)

framepoints,trkbond[n_elements(trkbond[*,0])-1,*],Ntrj,tp
for i=0L,Ntrj-1 do begin
 trj1=trkbond[0:3,tp[i]:tp[i+1]-1]
x1=mean(trj1[0,*])
y1=mean(trj1[1,*])
if (i mod 50) eq 0 then print,i
 for j=0L,Ntrj-1 do begin ;C6t only shift trj2, so j=i,Ntrj-1 lost half info
  trj2=trkbond[0:3,tp[j]:tp[j+1]-1]
x2=mean(trj2[0,*])
y2=mean(trj2[1,*])
  r=sqrt((x1-x2)^2+(y1-y2)^2)
  if r lt rrange then begin
   Ct=C6t(trj1,trj2,dt)
   res[*,r/rbinsize,*]=res[*,r/rbinsize,*]+Ct
  endif
 endfor
endfor
res[0,*,*]=res[0,*,*]/res[1,*,*]
write_gdf,res,outfile
end

;trj:[x,y,angle,t], trj1 and trj2 may have different length with missing frames
;C6t only shift trj2, so C6t(trj1,trj2...) + C6t(trj2,trj1...)
;has full info
;return C6t of trj1 and trj2 & weights
;with length mydts, if try1 and trj2
;not long enough, res[long t] and count[long t] will be 0.
;true C6t=res[0,*]/res[1,*]
function C6t,trj1,trj2,dt

;if not keyword_set(mydts) then mydts=[0]
ndt=n_elements(dt)
res=complexarr(2,ndt);[total C6t, count]

t2=max(trj2[3,*])+1
p=where(dt lt t2,newndt)
;include missing point when memory>1 in track.pro
fulltrj1=complexarr(max(trj1[3,*])+1)
fulltrj1[trj1[3,*]]=complex( cos(6*trj1[2,*]), sin(6*trj1[2,*]) )
fulltrj2=complexarr(t2)
fulltrj2[trj2[3,*]]=complex( cos(6*trj2[2,*]), sin(6*trj2[2,*]) )

for i=0,newndt-1 do begin
 try=fulltrj1*conj(fulltrj2[dt[i]:t2-1])
 p=where(try ne 0,count)
 res[1,i]=count
 res[0,i]=total(try)
endfor

return,res
end
