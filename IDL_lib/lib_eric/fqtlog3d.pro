function fqtlog3d,trb,qx=qx,qy=qy,qz=qz
tmax=max(trb(7,*))-min(trb(7,*))+1
dt = round(1.15^findgen(150))
dt = dt(uniq(dt))
w1 = where( dt lt 0.8*tmax, ndt )
dt=dt[w1]
a100=complex(0,1)
fqt1=findgen(2,ndt)
for j=0,ndt-1 do begin
dx=getdx(trb,dt[j],dim=3)
print,dt[j]
w=where(dx(3,*) gt 0.)
fqt1(1,j)=abs(mean(exp(a100*(qx*dx(0,w)+qy*dx(1,w)+qz*dx(2,w)))))
endfor
fqt1(0,*)=transpose(dt)
return,fqt1
end