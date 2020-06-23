function boo2davgt,trb,deltar=deltar
tmax=max(trb(5,*))-min(trb(5,*))+1
n1=max(trb(6,*))-min(trb(6,*))+1
for t=1,tmax-1 do begin
;print,t
b03=findgen(tmax,n1)
w=where(trb(5,*) eq t)
trc=trb(*,w)
b01=boo2d(trc,deltar=deltar)
b03(t,*)=b01(2,*)
endfor
dt = round(1.15^findgen(150))
dt = dt(uniq(dt))
w = where( dt le tmax, ndt )
for ti=0, ndt-1 do begin
lj=fltarr(1,n1)
;print,ti
delt=dt[ti]
for t1=0,tmax-delt-1 do begin
t2=t1+delt
li=b03(t2,*)-b03(t1,*)
lj=lj+li
endfor
lj=lj/(tmax-delt-1)
lk=findgen(3,ndt)
lk(0,ti)=delt
lk(1,ti)=mean(lj)
lk(2,ti)=variance(lj)
endfor
return,lk
end

    