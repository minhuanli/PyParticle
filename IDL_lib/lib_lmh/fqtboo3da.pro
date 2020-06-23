function fqtboo3da,trb,tra,tpercent=tpercent,qx=qx,qy=qy,qz=qz
ncol=n_elements(trb(*,0))
tmax=max(trb(ncol-2,*))-min(trb(ncol-2,*))+1
dt = round(1.15^findgen(150))
dt = dt(uniq(dt))
w1 = where( dt lt 1.0*tmax, ndt )
dt=dt[w1]
a100=complex(0,1)
fqt1=fltarr(6,ndt)
nid=trb(ncol-1,*)
nid=nid(uniq(nid,sort(nid)))
nd=n_elements(nid)
trb1=trb
trb1(0,*)=trb1(13,*)
for j=0,ndt-1 do begin
wa=[0]
print,dt[j]
dx=getdx(trb,dt[j],dim=3)
dq=getdx(trb1,dt[j],dim=3)
for i=0.,nd-1 do begin
wp=where(trb(ncol-1,*) eq nid[i],np)
tb=max(trb(ncol-2,wp))
wpp=where(trb(ncol-2,wp) le tb-dt[j],npp)
wppp=where(trb(ncol-2,wp) le tb-dt[j] and dx(3,wp) gt 0,nppp)
;dx=getdx(trb(*,wp),dt[j],dim=3)
if npp gt 0 and nppp*1.0/npp gt tpercent then begin
wa=[wa,wp[wppp]]
endif
endfor
npa=n_elements(wa)
wa=wa(1:npa-1)
;print,dt[j]
;w=where(dx(3,*) gt 0.,nw)
if npa gt 1 then begin
fqt1(1,j)=abs(mean(exp(a100*(qx*dx(0,wa)+qy*dx(1,wa)+qz*dx(2,wa)))))
fqt1(2,j)=real_part(mean(exp(a100*(qx*dx(0,wa)+qy*dx(1,wa)+qz*dx(2,wa)))))
dqa=dq(0,wa)
wqa=where(dqa eq 0,nqa)
wqb=where(dqa ne 0,nqb)
dqa(0,wqa)=1.0
dqa(0,wqb)=10.0
fqt1(5,j)=nqa*1.0/n_elements(dqa)
fqt1(3,j)=abs(mean(exp(-1.0*(dqa))))
fqt1(4,j)=variance(dqa)
endif
endfor
fqt1(0,*)=transpose(dt)
return,fqt1
end