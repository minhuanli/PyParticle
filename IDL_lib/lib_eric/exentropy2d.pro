pro exentropy2d,pos,s1,g1,rmin=rmin,rmax=rmax,deltar=deltar
x11=findgen(513)
y11=findgen(513)
x111=findgen(513,513)
y111=findgen(513,513)
for m=0,512 do begin
for n=0,512 do begin
x111(m,n)=x11[m]
y111(m,n)=y11[n]
endfor
endfor
x11=reform(x111,1,513.*513)
y11=reform(y111,1,513.*513)
n1=n_elements(pos(0,*))
rou1=1.0*n1/((max(pos(0,*))-min(pos(0,*)))*(max(pos(1,*))-min(pos(1,*))))
n2=round((rmax-rmin)/deltar)
r1=rmin+findgen(n2)
g02=findgen(n1,n2-1)
for j=0,n1-1 do begin
print,j
pos1=pos
dx=pos(0,*)-pos(0,j)
dy=pos(1,*)-pos(1,j)
dxx=x11-pos(0,j)
dyy=y11-pos(1,j)
c1=findgen(2,n1)
c1(0,*)=dx
c1(1,*)=dy
c2=findgen(2,513.*513)
c2(0,*)=dxx
c2(1,*)=dyy
pol1=cv_coord(from_rect=c1,/to_polar)
pol12=cv_coord(from_rect=c2,/to_polar)
for i=0,n2-2 do begin
w=where(pol1(1,*) gt r1[i] and pol1(1,*) lt r1[i+1])
w11=where(pol12(1,*) gt r1[i] and pol12(1,*) lt r1[i+1])
b1=n_elements(w)
b11=n_elements(w11)
if w[0] ne -1 then begin
g01=1.*b1/b11
g02[j,i]=g01/rou1
endif
if w[0] eq -1 then begin
g02(j,i)=0.0000001
endif
endfor
endfor
g06=findgen(n1)
g006=rebin(g02,1,n2-1)
for k=0,n1-1 do begin
g03=g02(k,*)
g04=2.0*!pi*(g03*alog(g006)-g03+1)*r1[0:n2-2]
g05=integral(r1[0:n2-2],g04)
g07=-0.5*rou1*g05
g06[k]=g07
endfor
s1=g06
g1=g02
end

