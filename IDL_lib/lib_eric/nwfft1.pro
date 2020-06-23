;simple test, no time average
pro nwfft1,trb,nw,jtt,n_smooth=n_smooth
trbc=trb
n1=max(trb(6,*))+1
t1=max(trb(5,*))-min(trb(5,*))+1
for i=0,n1-1 do begin
w=where(trb(6,*) eq i)
trc=trb(*,w)
dx=deriv(trc(5,*),trc(0,*))
dy=deriv(trc(5,*),trc(1,*))
trc(2,*)=smooth(dx,n_smooth)
trc(3,*)=smooth(dy,n_smooth)
trbc(*,w)=trc
endfor
trbb=trbc
dt=findgen(t1)
vab=findgen(2,t1)
vab(0,*)=dt

for j=0,t1-1 do begin
delt=dt[j]
print,j
tk=0
vaa=0.0
t2=tk+delt
w1=where(trbb(5,*) eq tk)
vx1=trbb(2,w1)
vy1=trbb(3,w1)
w2=where(trbb(5,*) eq t2)
vx2=trbb(2,w2)
vy2=trbb(3,w2)
vaa=vaa+total(vx1*vx2+vy1*vy2)
vab(1,j)=vaa
endfor
vab(1,*)=vab(1,*)/vab(1,0)
omgab=fft(vab(1,*),-1)
nw=omgab
jtt=vab
end
