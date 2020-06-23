function vecpr1,vecs,vess
s1=size(vecs)
l=s1[1]
m=s1[2]
vecs03=findgen(2,m)
for j=0,m-1 do begin
vecs002=vecs(*,j)^4
vecs03(1,j)=total(vecs002)
vecs03(0,j)=1./sqrt(abs(vess(0,j)))
endfor
vecs03(1,*)=2./(vecs03(1,*)*l)
return,vecs03
end