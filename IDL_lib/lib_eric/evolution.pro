function evolution,pos1,pos2,evc1,evc2
c01=ckt1(pos1,pos2,evc1)
n1=n_elements(pos1)
pp02=findgen(2,n1)
for j=0,n1-1 do begin
a1=c01(0,j)
a2=c01(1,j)
pp01=abs(total(evc1(*,a1)*evc2(*,a1)))
pp02(0,j)=a1
pp02(1,j)=pp01
endfor
pp03=pp02
return,pp03
end