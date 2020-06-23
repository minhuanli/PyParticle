function exentropy3d,pos,rmin=rmin,rmax=rmax,deltar=deltar
n1=n_elements(pos(0,*))
rou1=1.0*n1/((max(pos(0,*))-min(pos(0,*)))*(max(pos(1,*))-min(pos(1,*)))*(max(pos(2,*))-min(pos(2,*))))
n2=round((rmax-rmin)/deltar)
r1=rmin+findgen(n2)*deltar
g02=findgen(n1,n2-1)
for j=0.,n1-1 do begin
pos1=pos
dx=pos(0,*)-pos(0,j)
dy=pos(1,*)-pos(1,j)
dz=pos(2,*)-pos(2,j)
c1=findgen(3,n1)
c1(0,*)=dx
c1(1,*)=dy
c1(2,*)=dz
w11=where(c1(0,*)^2+c1(1,*)^2+c1(2,*)^2 lt rmax^2)
c2=c1(*,w11)
pol1=cv_coord(from_rect=c2,/to_sphere)
for i=0.,n2-2 do begin
w=where(pol1(2,*) gt r1[i] and pol1(2,*) lt r1[i+1])
b1=n_elements(w)
if w[0] ne -1 then begin
s1=((r1[i])^2)*deltar*(4*!pi)
g01=1.*b1/s1
g02[j,i]=g01/rou1
endif
if w[0] eq -1 then begin
g02(j,i)=0.00001
endif
endfor
endfor
g06=findgen(n1)
for k=0,n1-1 do begin
g03=g02(k,*)
g04=(g03*alog(g03)-g03+1)*4.0*!pi*r1*r1*deltar
g05=-0.5*total(g04)*rou1
g06[k]=g05
print,k
endfor
return,g06
end

