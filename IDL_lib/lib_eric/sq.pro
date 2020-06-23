function sq,pos
theta=findgen(100)*2*!pi/100
c=(findgen(512)+1)*2*!pi/(512)
n1=n_elements(pos(0,*))
b=complex(0,1)
a1=findgen(100,n1)
b1=findgen(100,n1)
a001=findgen(100)
b001=findgen(100)
a3=findgen(512)
for j=0,511 do begin
c1=c[j]
for i=0,99 do begin
for k=0,n1-1 do begin
a1(i,k)=exp(c1*b*(cos(theta[i])*pos(0,k)+sin(theta[i])*pos(1,k)))
b1(i,k)=exp(-c1*b*(cos(theta[i])*pos(0,k)+sin(theta[i])*pos(1,k))) 
endfor
a01=abs(total(a1(i,*)))
b01=abs(total(b1(i,*)))
a001[i]=a01
b001[i]=b01
endfor
a2=mean(a001*b001)
a3[j]=a2
endfor
s1=findgen(2,512)
s1(0,*)=c
s1(1,*)=a3/n1
return,s1
end

