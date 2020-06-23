;LMH gr3d for specific particles in a box-like database 2017/09/07  @fudan
;calcualte the gr of certain particles in the whole system database
;!!!!Make sure the x,y of cpdata stand at the center core of database, at least rmax far away from the boundary!!!!

;the z position of cpdata can be around the boundary. i follow E.Weeks did, slicing off sphere area out of the boundary, when z+rmax > zmax or z-rmax < zmax 
;the outer sphere area is 2piR0(R0-dz), R0 is sphere radius and dz is distance from cp to boundary
;so the remaining sphere area is 4 pi R0 dz, dz is the z distance locating inside boundary

;this process can not be used in condition with time series, but u can do a little modification to do this
function gr3d_corr,cpdata=cpdata,data=data,rmin=rmin,rmax=rmax,deltar=deltar
n0=n_elements(data(0,*))
n1=n_elements(cpdata(0,*))
rou0 = 1.0*n0/((max(data(0,*))-min(data(0,*)))*(max(data(1,*))-min(data(1,*)))*(max(data(2,*))-min(data(2,*))))  ; number density of the whole system for normalization

n2=round((rmax-rmin)/deltar)
r1=findgen(n2)
r1=rmin+r1*deltar
g02=fltarr(n2-1,n1);result
g02(*) = 0.00001
zmax=max(data(2,*)) 
zmin=min(data(2,*)) ; the z-axis boundary of the data box
for i=0,n1-1 do begin
  dx=data(0,*)-cpdata(0,i)
  dy=data(1,*)-cpdata(1,i)
  dz=data(2,*)-cpdata(2,i)
  c1=fltarr(3,n0)
  c1(0,*)=dx
  c1(1,*)=dy
  c1(2,*)=dz
  w11=where(c1(0,*)^2+c1(1,*)^2+c1(2,*)^2 lt rmax^2)
  c2=c1(*,w11)
  pol1=cv_coord(from_rect=c2,/to_sphere)
  for j = 0,n2-2 do begin
    w=where(pol1(2,*) ge r1[j] and pol1(2,*) lt r1[j+1],b1)   ; n2-1 intervals in total
    if b1 eq 0 then continue
    z0up=min([r1[j],zmax-cpdata(2,i)])
    z0down=min([r1[j],cpdata(2,i)-zmin])
    z0=z0up+z0down
    r0=min([2*r1[j],z0])  ; slicing off the sphere out of boundary
    dv=(r1[j]*r0)*deltar*(2*!pi) ; sphere shell volume at r1(j)
    g02(j,i)=float(b1)/(dv*rou0) ; gr for center particle i at distance r1(j)   
  endfor
  ;if i mod 1000 eq 0 then print,'gr'+string(i)
endfor 

return,g02

end
;--------------------------------------------------------------------------
;-------------------------------------------------------------------
function stwo3d,cpdata=cpdata,data=data,rmin=rmin,rmax=rmax,deltar=deltar
n0=n_elements(data(0,*))
n1=n_elements(cpdata(0,*))
n2=round((rmax-rmin)/deltar)
r1=findgen(n2)
r1=rmin+r1*deltar
rou0 = 1.0*n0/((max(data(0,*))-min(data(0,*)))*(max(data(1,*))-min(data(1,*)))*(max(data(2,*))-min(data(2,*))))

g02=gr3d_corr(cpdata=cpdata,data=data,rmin=rmin,rmax=rmax,deltar=deltar)
g06=findgen(n1)
for k=0,n1-1 do begin
  g03=g02(*,k)
  g04=(g03*alog(g03)-g03+1)*4.0*!pi*r1[0:n2-2]*r1[0:n2-2]*deltar
  g05=-0.5*total(g04)*rou0
  g06[k]=g05
  if k mod 1000 eq 0 then print,'s2'+string(k)
endfor
return,g06
end
