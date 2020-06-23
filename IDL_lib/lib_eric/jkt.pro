;calculation transverse and longitudinal momentum current correlation.
pro jkt,trb,jktr,jklo,cktr1,cklo1,theta=theta
trbb=trb
n1=max(trbb(6,*))+1
t1=max(trbb(5,*))-min(trb(5,*))+1
jtr=complexarr(t1,64)
jlo=complexarr(t1,64)
for i=0,n1-1 do begin
w=where(trbb(6,*) eq i)
trc=trbb(*,w)
dx=deriv(trc(5,*),trc(0,*))
dy=deriv(trc(5,*),trc(1,*))
trc(2,*)=dx
trc(3,*)=dy
trbb(*,w)=trc
endfor
ka=(findgen(64)+1)*2*!pi/512
b=complex(0,1)
for j=0,t1-1 do begin
print,j
for k=0,63 do begin
w1=where(trbb(5,*) eq j)
trcc=trbb(*,w1)
jtr(j,k)=abs(total((trcc(2,*)*sin(theta)-trcc(3,*)*cos(theta))*exp(b*ka[k]*(cos(theta)*trcc(0,*)+sin(theta)*trcc(1,*)))))
jlo(j,k)=abs(total((trcc(2,*)*cos(theta)+trcc(3,*)*sin(theta))*exp(b*ka[k]*(cos(theta)*trcc(0,*)+sin(theta)*trcc(1,*)))))
endfor
endfor
jktr=jtr
jklo=jlo
dt=findgen(t1)
ctr=fltarr(1,64)
clo=fltarr(1,64)
cktr=findgen(64,t1)
cklo=findgen(64,t1)
for tj=0,t1-1 do begin
delt=dt[tj]
print,tj
for tk=0,t1-delt-1 do begin
t2=tk+delt
ctr=ctr+jktr(tk,*)*jktr(t2,*)
clo=clo+jklo(tk,*)*jklo(t2,*)
endfor
cktr(*,tj)=ctr
cklo(*,tj)=clo
endfor
cktr1=cktr
cklo1=cklo
end