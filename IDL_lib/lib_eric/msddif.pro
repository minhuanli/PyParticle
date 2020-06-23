pro msddif,trb,m1,m2,m3,max=max
n0=max(trb(6,*))+1
t0=max(trb(5,*))+1
pos=position(trb)
ps6=psi6(pos,polar=1)
p6=mean(ps6(0,*))
w1=where(ps6(0,*) ge p6)
w2=where(ps6(0,*) lt p6)
n1=w1
n2=w2
s1=n_elements(n1)
s2=n_elements(n2)
trc=findgen(7,t0*s1)
for j=0,s1-1 do begin
w3=where(trb(6,*) eq n1[j])
t1=t0*j
t2=t0*(j+1)-1
print,j
trc(*,t1:t2)=trb(*,w3)
endfor
trd=findgen(7,t0*s2)
for i=0,s2-1 do begin
w4=where(trb(6,*) eq n2[i])
t3=t0*i
t4=t0*(i+1)-1
print,i
trd(*,t3:t4)=trb(*,w4)
endfor
m1=msd(trc,dim=2,maxtime=max)
m2=msd(trd,dim=2,maxtime=max)
m3=msd(trb,dim=2,maxtime=max)
end
