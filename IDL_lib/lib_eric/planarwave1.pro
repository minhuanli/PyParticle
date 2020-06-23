;returns transverse and longitudinal dynamic structure factor in w-q space
pro planarwave1,evc,pos,ftr,flo
n1=n_elements(evc(0,*))
ftr1=findgen(64,n1)
flo1=findgen(64,n1)
for j=0,n1-1 do begin
evc01=evc(*,j)
p01=planarwave(evc01,pos)
ftr1(*,j)=p01(0,*)
flo1(*,j)=p01(1,*)
print,j
endfor
ftr=ftr1
flo=flo1
end