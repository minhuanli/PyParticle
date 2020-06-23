function fqtlog,trb,qx=qx,qy=qy
tmax=max(trb(5,*))-min(trb(5,*))+1
dt = round(1.15^findgen(150))
dt = dt(uniq(dt))
w1 = where( dt lt 0.6*tmax, ndt )
dt=dt[w1]
a100=complex(0,1)
fqt1=findgen(2,ndt)
for j=0,ndt-1 do begin
dx=getdx(trb,dt[j],dim=2)
print,dt[j]
w=where(dx(2,*) gt 0.)
fqt1(1,j)=abs(mean(exp(a100*(qx*dx(0,w)+qy*dx(1,w)))))
endfor
fqt1(0,*)=transpose(dt)
return,fqt1
end