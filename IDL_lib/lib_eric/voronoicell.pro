function voronoicell,trb,maxr=maxr
c1=trb(0:2,*)
na=n_elements(c1(0,*))
vl=fltarr(6,na)
vl(0:2,*)=c1
qhull,c1,tr1,connectivity=con1,vvertices=v1,/delaunay
for j=0.,na-1 do begin
w=where(tr1(0,*) eq j or tr1(1,*) eq j or tr1(2,*) eq j or tr1(3,*) eq j,nb)
c2=v1(*,w)
w22=con1[con1[j]:con1[j+1]-1]
c22=c1(*,w22)
qhull,c2,tr2,/delaunay
qhull,c22,tr22,/delaunay
va=tetra_volume(c2,tr2)
vaa=tetra_volume(c22,tr22)
if va lt 3.14*4.0*maxr*maxr*maxr/3.0 then begin
vl(3,j)=nb
vl(4,j)=va
vl(5,j)=vaa
endif
endfor
return,vl
end
