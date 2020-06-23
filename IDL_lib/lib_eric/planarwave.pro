;returns transverse and longitudinal current spectrum, theta are averaged
function planarwave,evc,pos
n1=n_elements(evc)
evc01=reform(evc,2,n1/2)
theta=findgen(100)*2*!pi/100
a1=findgen(100,n1/2)
b1=findgen(100,n1/2)
a001=findgen(100)
b001=findgen(100)
b=complex(0,1)
c=(findgen(64)+1)*2*!pi/512
a3=findgen(64)
b3=findgen(64)
for j=0,63 do begin
c1=c[j]
for i=0,99 do begin
for k=0,n1/2-1 do begin
a1(i,k)=(cos(theta[i])*evc01(0,k)+sin(theta[i])*evc01(1,k))*exp(c1*b*(cos(theta[i])*pos(0,k)+sin(theta[i])*pos(1,k)))
b1(i,k)=(cos(theta[i])*evc01(1,k)-sin(theta[i])*evc01(0,k))*exp(c1*b*(cos(theta[i])*pos(0,k)+sin(theta[i])*pos(1,k)))
endfor
a01=(abs(total(a1(i,*))))^2
b01=(abs(total(b1(i,*))))^2
a001[i]=a01
b001[i]=b01
endfor
a2=mean(a001)
b2=mean(b001)
a3[j]=a2
b3[j]=b2
endfor
d3=a3
d4=b3
d03=findgen(2,64)
d03(0,*)=d4
d03(1,*)=d3
return,d03
end