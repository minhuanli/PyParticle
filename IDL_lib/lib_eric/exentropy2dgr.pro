function exentropy2dgr,pos,rmin=rmin,rmax=rmax,deltar=deltar
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
g02a=findgen(n1,n2-1)
g02aa=findgen(n1,n2-1)
p6=transpose(psi6(pos))

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
w=where(pol1(1,*) gt r1[i] and pol1(1,*) lt r1[i+1],ncount)
w11=where(pol12(1,*) gt r1[i] and pol12(1,*) lt r1[i+1],ncounta)
if (ncount gt 0) then begin
g01=1.*ncount/ncounta
g01a=abs(total(p6(0,i)*conj(p6(0,w)))/ncounta)
g01aa=real_part(total(p6(0,i)*conj(p6(0,w)))/ncounta)
g02[j,i]=g01/rou1
g02a[j,i]=g01a/rou1
g02aa[j,i]=g01a/rou1
endif else begin
g02(j,i)=0.0
g02a(j,i)=0.0
g02aa(j,i)=0.0
endelse
endfor
endfor
g06=findgen(4,n2-1)
for k=0,n2-2 do begin
g03=g02(*,k)
g03a=g02a(*,k)
g03aa=g02aa(*,k)
g04=mean(g03)
g04a=mean(g03a)
g04aa=mean(g03aa)
g06[1,k]=g04
g06[2,k]=g04a
g06[3,k]=g04aa
endfor
g06(0,*)=transpose(r1(0:n2-2))
return,g06
end

