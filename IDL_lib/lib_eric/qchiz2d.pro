function qchiz2d,xyt,qt,a
s=size(qt)
width=s[1]
hight=s[2]
ndt=s[3]
w=where(xyt(2,*) eq 1 and xyt(5,*) eq 0,ncountj)
pin=xyt(0:1,w)/a
dim=min([width,hight])/2+1
qz=fltarr(dim,ndt)
for i=0,ndt-1 do begin
 qt1=qt(*,*,i)
 qt2=fltarr(dim,ncountj)
   for j=0,ncountj-1 do begin
     av1=aziavg(qt1,center=pin(0:1,j))
     qt2(*,j)=av1
   endfor
qt2=rebin(qt2,dim,1)
qz(*,i)=qt2
endfor
    for k=0,dim-1 do begin
    qz(k,*)=qz(k,*)/qz(k,0)
    endfor
return,qz
end



  