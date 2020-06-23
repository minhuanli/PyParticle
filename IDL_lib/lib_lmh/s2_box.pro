;divide the whole system into boxes, and lable the part
pro box_system,data=data,xnum=xnum,ynum=ynum,znum=znum
xmin=min(data(0,*))
xmax=max(data(0,*))
deltax=(xmax-xmin)/xnum

ymin=min(data(1,*))
ymax=max(data(1,*))
deltay=(ymax-ymin)/ynum

zmin=min(data(2,*))
zmax=max(data(2,*))
deltaz=(zmax-zmin)/znum

n0=n_elements(data(0,*))
label=fltarr(1,n0)
flag=0
for i = 0, xnum-1 do begin
   for j = 0, ynum-1 do begin
      for k = 0, znum-1 do begin
          w=where(data(0,*) ge (xmin+i*deltax) and data(0,*) lt (xmin+(i+1)*deltax) and $ 
          data(1,*) ge (ymin+j*deltay) and data(1,*) lt (ymin+(j+1)*deltay) and $
          data(2,*) ge (zmin+k*deltaz) and data(2,*) lt (zmin+(k+1)*deltaz))
          label(0,w)=flag
          flag=flag+1
      endfor
   endfor
endfor
print,flag
data=[data,label]
end

;----------------------------------------------------------------------------------------

function gr3dt,cpdata=cpdata,data=data,rmin=rmin,rmax=rmax,deltar=deltar
n1=n_elements(cpdata(0,*))
nclo=n_elements(data(*,0))

n2=round((rmax-rmin)/deltar)
r1=findgen(n2)
r1=rmin+r1*deltar
g02=fltarr(n2-1,n1);no average result
g03=fltarr(n2-1) ; average over particles result
g02(*) = 0.00001
for i=0,n1-1 do begin
  ti = cpdata(nclo-2,i)
  datat=eclip(data,[nclo-2,ti,ti])
  n0=n_elements(datat(0,*))
  rou0 = 1.0*n0/((max(datat(0,*))-min(datat(0,*)))*(max(datat(1,*))-min(datat(1,*)))*(max(datat(2,*))-min(datat(2,*))))  ; number density of the whole system for normalization
  dx=datat(0,*)-cpdata(0,i)
  dy=datat(1,*)-cpdata(1,i)
  dz=datat(2,*)-cpdata(2,i)
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
    dv=((r1[j])^2)*deltar*(4*!pi) ; sphere shell volume at r1(j)
    g02(j,i)=float(b1)/(dv*rou0) ; gr for center particle i at distance r1(j)   
  endfor
  ;if i mod 1000 eq 0 then print,'gr'+string(i)
endfor 

for i = 0 , n2-2 do begin
  g03(i)=mean(g02(i,*))
endfor

return,g03
end

;---------------------------------------------------------------------------------------------
;u should box label the whole system and cpdata before the following calculation
function s2_box,data=data,cpdata=cpdata,rmin=rmin,rmax=rmax,deltar=deltar,boxn=boxn
nclo=n_elements(data(*,0))
boxmin=min(cpdata(nclo-1,*))
boxmax=max(cpdata(nclo-1,*))

tmin=min(data(nclo-2,*))
tmax=max(data(nclo-2,*))
nt=tmax-tmin+1
n0=n_elements(data(0,*))
rou0 = 1.0*n0/(nt*((max(data(0,*))-min(data(0,*)))*(max(data(1,*))-min(data(1,*)))*(max(data(2,*))-min(data(2,*)))))

n2=round((rmax-rmin)/deltar)
r1=findgen(n2)
r1=rmin+r1*deltar
s2box=fltarr(2,boxn)
flag=0L
for i = boxmin, boxmax do begin 
   w=where(cpdata(nclo-1,*) eq i,nw)
   if nw eq 0 then continue
   flag=flag+1L
   cpdatai=cpdata(*,w)
   s2box(0,i)=n_elements(cpdatai(0,*))
   g03=gr3dt(cpdata=cpdatai,data=data,rmin=rmin,rmax=rmax,deltar=deltar)
   g04=(g03*alog(g03)-g03+1)*4.0*!pi*r1[0:n2-2]*r1[0:n2-2]*deltar
   s2box(1,i)=-0.5*total(g04)*rou0
   if flag mod 100 eq 0 then print,'box'+string(flag)
endfor

return,s2box

end

