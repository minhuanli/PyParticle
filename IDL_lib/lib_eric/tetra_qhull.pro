;calculate tetracity of networks. input the positions trb.
;tr2 contains the tetracity of each tetra (tr2(7,*) is the tetra volume, tr2(8,*) is tetracity, 
;tr3 contains the tetracity of particles. (3,*) is the tetracity, (4,*)is number id tetra, (5,*) total tetra
pro tetra_qhull,trb,tr2,tr3
c1=trb(0:2,*)
qhull,c1,tr1,connectivity=con1,/delaunay
na=n_elements(tr1(0,*))
tr2=fltarr(9,na)
tr2(0:3,*)=tr1
for j=0.,na-1 do begin
w11=tr1(*,j)
pos=c1(*,w11)
va=tetra_volume(pos,[0,1,2,3])
dx=[pos(0,0)-pos(0,1),pos(0,0)-pos(0,2),pos(0,0)-pos(0,3),pos(0,1)-pos(0,2),pos(0,1)-pos(0,3),pos(0,2)-pos(0,3)]
dy=[pos(1,0)-pos(1,1),pos(1,0)-pos(1,2),pos(1,0)-pos(1,3),pos(1,1)-pos(1,2),pos(1,1)-pos(1,3),pos(1,2)-pos(1,3)]
dz=[pos(2,0)-pos(2,1),pos(2,0)-pos(2,2),pos(2,0)-pos(2,3),pos(2,1)-pos(2,2),pos(2,1)-pos(2,3),pos(2,2)-pos(2,3)]
dr=sqrt(dx^2+dy^2+dz^2)
s01=stddev(dr)/mean(dr)
tr2(7,j)=va
tr2(8,j)=s01
tr2(4,j)=mean(pos(0,[0,1,2,3]))
tr2(5,j)=mean(pos(1,[0,1,2,3]))
tr2(6,j)=mean(pos(2,[0,1,2,3]))
endfor
con=con1
nb=n_elements(c1(0,*))
c2=fltarr(6,nb)
c2(0:2,*)=c1
for i=0.,nb-1 do begin
w1=where(tr2(0,*) eq i or tr2(1,*) eq i or tr2(2,*) eq i or tr2(3,*) eq i,n12)
tr33=tr2(*,w1)
w2=where(tr33(8,*) lt 0.1,n11)  ;dc here
if n11 gt 0 then begin
vb=mean(tr33(4,w2))
s02=1.0*n11/n12
c2(3,i)=s02
c2(4,i)=n11
c2(5,i)=n12
endif
endfor
tr3=c2
end


