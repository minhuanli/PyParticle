;calculate 2D x y transverse and longitudinal current spectrum of one mode
pro planarwavexy,evc,pos,ftr,flo
n1=n_elements(evc)
evc01=reform(evc,2,n1/2)
qx=[-64,64]*2*!pi/512
qy=[-64,64]*2*!pi/512
b=complex(0,1)
qxx=interpol(qx,129)
qyy=interpol(qy,129)
f1=fltarr(129,129,n1/2)
f01=fltarr(129,129)
f2=fltarr(129,129,n1/2)
f02=fltarr(129,129)
theta=fltarr(129,129)
for i=0,128 do begin
for j=0,128 do begin
for k=0,n1/2-1 do begin
f1(i,j,k)=(evc01(0,k)*qyy[j]/sqrt(qxx[i]^2+qyy[j]^2)-evc01(1,k)*qxx[i]/sqrt(qxx[i]^2+qyy[j]^2))*exp(b*(qxx[i]*pos(0,k)+qyy[j]*pos(1,k)))
f2(i,j,k)=(evc01(0,k)*qxx[i]/sqrt(qxx[i]^2+qyy[j]^2)+evc01(1,k)*qyy[j]/sqrt(qxx[i]^2+qyy[j]^2))*exp(b*(qxx[i]*pos(0,k)+qyy[j]*pos(1,k)))
endfor
f01(i,j)=(abs(total(f1(i,j,*))))^2
f02(i,j)=(abs(total(f2(i,j,*))))^2
endfor
endfor
f01(64,64)=0
f02(64,64)=0
ftr=f01
flo=f02
end