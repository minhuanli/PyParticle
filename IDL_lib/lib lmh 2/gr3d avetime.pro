;LMH gr3d for specific particles in a box-like database 2017/09/07  @fudan
;calcualte the gr of certain particles in the whole system database
;!!!!Make sure the x,y of cpdata stand at the center core of database, at least rmax far away from the boundary!!!!

;the z position of cpdata can be around the boundary. i follow E.Weeks did, slicing off sphere area out of the boundary, when z+rmax > zmax or z-rmax < zmax 
;the outer sphere area is 2piR0(R0-dz), R0 is sphere radius and dz is distance from cp to boundary
;so the remaining sphere area is 4 pi R0 dz, dz is the z distance locating inside boundary

;this process can not be used in condition with time series, but u can do a little modification to do this
function gr3d_corr1,cpdata=cpdata,data=data,rmin=rmin,rmax=rmax,deltar=deltar
cppos=cpdata(0:2,*)
pos=data(0:2,*)
n0=n_elements(pos(0,*))
n1=n_elements(cppos(0,*))
xmin=min(pos(0,*),max=xmax)
ymin=min(pos(1,*),max=ymax)
zmin=min(pos(2,*),max=zmax)
rou0 = 1.0*n0/((zmax-zmin)*(xmax-xmin)*(ymax-ymin))  ; number density of the whole system for normalization
n2=(rmax-rmin)/deltar
rvec=findgen(n2)*deltar+rmin

g02=fltarr(n2,n1);result
g02(*) = 0.00001
one=fltarr(n0)+1.0
rmin2=rmin*rmin
rmax2=rmax*rmax
for i=0,n1-1 do begin  
  ;wi=where(
  d0=cppos(*,i)
  dd=one##d0-pos
  dis=total(dd*dd,1)
  w2=where(dis gt rmin2 and dis lt rmax2,nw2)
  if (nw2 gt 0) then begin
; if (min(dis(w2)) lt 0.1) then message,'foo',/inf
    newdis=sqrt(dis(w2))
    thehisto=histogram(newdis,max=rmax,min=rmin,binsize=deltar)
    z0=zmax-d0(2)
    z1=d0(2)-zmin
    normz=2*!pi*rvec*( (rvec<z0) + (rvec<z1) )* rou0 * deltar
    normz(0)=1.0
    normz=1.0/normz
    normz(0)=0.0
    g02(*,i)=thehisto*normz+0.00001
  endif
    ;dv=(r1[j]*r0)*deltar*(2*!pi) ; sphere shell volume at r1(j)
   ; g02(j,i)=float(b1)/(dv*rou0) ; gr for center particle i at distance r1(j)    
  ;if i mod 1000 eq 0 then print,'gr'+string(i)
endfor 

return,g02

end

; LMH 17.9.7 gr3d with averaged over time  @fudan
; calculate gr averaged over time of a specific particle with certain tracked id
; we pick all particles with the same id in the database and calculate all their gr to do an average
; we need ncol-2 in the data is id, ncol-1 is the type(sld,liq,pre,teag), ncol-3 is time 
; we assume cpdata only have one particle, u can easily do some modification
; output: 0) num with same id 1)percentage with same type in the series  rest)averaged gr,
function gr3d_avetime,cpid=cpid,type=type,data=data,rmin=rmin,rmax=rmax,deltar=deltar 
	ncol = n_elements(data(*,0))
	type = type
	id = cpid
	w = where(data(ncol-2,*) eq id,nw)  ; nw is the number of particles with same id
	n2 = (rmax-rmin)/deltar
	res0 = fltarr(n2,nw)
	count = 0 
	for i = 0l,nw-1 do begin 
	  start=systime(/second)
	  if data(ncol-1,w(i)) eq 0 then nw = nw-1
	  ;if data(ncol-1,w(i)) eq 0 then print,'near the boundary!!!'
	  if data(ncol-1,w(i)) eq 0 then continue
	  t = data(ncol-3,w(i))   ; w(i) in data 
 	  datat =eclip(data,[ncol-3,t,t])
		res0(*,i) = gr3d_corr1(cpdata=data(*,w(i)),data=datat,rmin=rmin,rmax=rmax,deltar=deltar)
		if data(ncol-1,w(i)) eq type then count=count+1
		endtime=systime(/second)
		time=endtime-start
		print,string(i)+'time'+string(time)
	endfor
	res1 = fltarr(n2-1,1)
	for j = 0, n2-2 do begin
		res1(j,0) = mean(res0(j,*))
	endfor
	res = [nw,count/nw,res1]
	return, res
end

;-----------------------------------------------------------------------------
function s23d_avetime,cpid=cpid,type=type,data=data,rmin=rmin,rmax=rmax,deltar=deltar
n1=n_elements(cpid) ; number of the target num 
n2=(rmax-rmin)/deltar
r1=findgen(n2)
r1=rmin+r1*deltar

n0=n_elements(data(0,*))/(max(data(17,*))-min(data(17,*)))
rou0 = 1.0*n0/((max(data(0,*))-min(data(0,*)))*(max(data(1,*))-min(data(1,*)))*(max(data(2,*))-min(data(2,*))))

g06=findgen(3,n1)
for k=0,n1-1 do begin
  g02=gr3d_avetime(cpid=cpid(k),type=type,data=data,rmin=rmin,rmax=rmax,deltar=deltar)
  g03=g02(2:n2,0)
  g04=(g03*alog(g03)-g03+1)*4.0*!pi*r1[0:n2-2]*r1[0:n2-2]*deltar
  g05=-0.5*total(g04)*rou0
  g06[2,k]=g05
  g06[0,k]=g02(0,0)
  g06[1,k]=g02(1,0)
  if k mod 1000 eq 0 then print,'s2'+string(k)
endfor
return,g06
end





