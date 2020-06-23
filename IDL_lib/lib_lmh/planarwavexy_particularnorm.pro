; calculate 2D x y transverse and longitudinal current spectrum of one mode
; with a perticular |q|.
pro planarwavexy_particularnorm,evc,pos,ftr,flo,qnorm=qnorm
n1=n_elements(evc)
evc01=reform(evc,2,n1/2)
qnorm12=[2,4]
qnorm=interpol(qnorm12,10)
thetaoriginal=[-1,1]*2*!pi
;qy=[-64,64]*2*!pi/192
b=complex(0,1)
ttheta=interpol(thetaoriginal,129)
f1=fltarr(10,129,n1/2)
f01=fltarr(10,129)
f2=fltarr(10,129,n1/2)
f02=fltarr(10,129)
for j=0,9 do begin
 q=2*!pi*exp(b*ttheta)/qnorm[j]
 qxx=real_part(q)
 qyy=imaginary(q)
 for i=0,128 do begin
  for k=0,n1/2-1 do begin
   f1(j,i,k)=(evc01(0,k)*qyy[i]/sqrt(qxx[i]^2+qyy[i]^2)-evc01(1,k)*qxx[i]/sqrt(qxx[i]^2+qyy[i]^2))*exp(b*(qxx[i]*pos(0,k)+qyy[i]*pos(1,k)))
   f2(j,i,k)=(evc01(0,k)*qxx[i]/sqrt(qxx[i]^2+qyy[i]^2)+evc01(1,k)*qyy[i]/sqrt(qxx[i]^2+qyy[i]^2))*exp(b*(qxx[i]*pos(0,k)+qyy[i]*pos(1,k)))
  endfor
  f01(j,i)=(abs(total(f1(j,i,*))))^2
  f02(j,i)=(abs(total(f2(j,i,*))))^2
 ;f01(i,j)=(total(f1(i,j,*)))^2
 ;f02(i,j)=(total(f2(i,j,*)))^2
 endfor
endfor
f01(*,64)=0
f02(*,64)=0
ftr=f01
flo=f02
end