;0,p6,1,real,2,img,3,bond,4,angle
function lindeman,trb,deltar=deltar
pos=position(trb)
t1=max(trb(5,*))-min(trb(5,*))+1
t2=findgen(t1)
n1=max(trb(6,*))-min(trb(6,*))+1
pos1=pos
for j=0,n1-1 do begin
pos1(0,*)=pos1(0,*)-pos(0,j)
pos1(1,*)=pos1(1,*)-pos(1,j)
a1=sqrt(pos1(0,*)^2+pos1(1,*)^2)
w=where(a1 gt 0 and a1 lt deltar)
for i=1,t1-1 do begin
dx=getdx(trb,t2[i])





function boo2d,tr,deltar=deltar
pos=tr(0:1,*)
n1=n_elements(pos(0,*))
qq1=findgen(5,n1)
a00=complex(0.0,1.0)
for j=0,n1-1 do begin
print,j
pos1=pos
pos1(0,*)=pos1(0,*)-pos(0,j)
pos1(1,*)=pos1(1,*)-pos(1,j)
a1=sqrt(pos1(0,*)^2+pos1(1,*)^2)
w=where(a1 gt 0 and a1 lt deltar)
b1=n_elements(w)
if w[0] ne -1 then begin
c1=findgen(2,b1)
c1(0,*)=pos1(0,w)
c1(1,*)=pos1(1,w)
sph1=cv_coord(from_rect=c1,/to_polar)
sum01=total(exp(a00*(6.0*sph1(0,*))))/b1
qq1(0,j)=abs(sum01)
qq1(1,j)=real_part(sum01)
qq1(2,j)=imaginary(sum01)
qq1(3,j)=b1
qq1(4,j)=atan(qq1(2,j),qq1(1,j))
endif
if w[0] eq -1 then begin
qq1(0,j)=0
qq1(1,j)=0
qq1(2,j)=0
qq1(3,j)=0
qq1(4,j)=0
endif
endfor
ql=qq1
q2=findgen(7,n1)
q2(0:1,*)=tr(0:1,*)
q2(2:6,*)=qq1
return,q2
end




