pro x4t,trb,dt,q2,x4
dl=(findgen(100)+1)*0.1
for j=0,99 do begin
q01=q4tlog(trb,deltarl=dl[j],points=20)
qa=findgen(100,20)
qa(j,*)=q01(1,*)
qb=findgen(100,20)
qb(j,*)=q01(2,*)
endfor
dt=q01(0,*)
q2=qa
x4=qb
end