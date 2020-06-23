;2)dwfactor,3)average square velocity
function mobility,trb
dim1=n_elements(trb(*,0))

n1=max(trb(dim1-1,*))
t1=max(trb(dim1-2,*))
pos01=position(trb)
mpos01=meanposition(trb)
m4=findgen(4,n1+1)
for j=0,n1 do begin
w=where(mpos01(dim1-1,*) eq j)
pos1=mpos01(*,w)
trb1=trb(*,w)
;dx1=getdx(trb1,500,dim=2)
;w2=where(dx1(2,*) gt 0)
;dx2=mean(dx1(2,w2)^2)
m1=mean(pos1(0,*)^2+pos1(1,*)^2)
m2=(mean(pos1(0,*)))^2+(mean(pos1(1,*)))^2
m3=m1-m2
m4(2,j)=m3
;m4(3,j)=dx2
endfor
m4(0,*)=pos01(0,*)
m4(1,*)=pos01(1,*)
mol=m4
return,mol
end