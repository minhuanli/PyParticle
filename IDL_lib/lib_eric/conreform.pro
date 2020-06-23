function conreform,c1,c2,p_num=p_num
n1=n_elements(c1)
t=1.0*n1/(p_num+1)
n2=1.0*p_num*t
trb=fltarr(7,n2)
for j=0,p_num-1 do begin
for i=0,t-1 do begin
c11=c1[(p_num+1)*i+j+1]
c12=c2[(p_num+1)*i+j+1]
trb(0,p_num*i+j)=c11
trb(1,p_num*i+j)=c12
trb(5,p_num*i+j)=i
trb(6,p_num*i+j)=j
endfor
endfor
trb(0,*)=(trb(0,*)+0.5)*500.0
trb(1,*)=(trb(1,*)+0.5)*500.0
trc=trb
for k=0,p_num-1 do begin
w1=where(trb(6,*) eq k)
na=1.0*t*k
nb=1.0*t*(k+1)-1
trc(0:1,na:nb)=trb(0:1,w1)
trc(5,na:nb)=findgen(1,t)
trc(6,na:nb)=k
endfor
return,trc
end
