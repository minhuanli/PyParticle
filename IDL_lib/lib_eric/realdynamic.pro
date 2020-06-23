;2-3是实际运动，4-5是摸地投影
function realdynamic,trb,evc,t1=t1,t2=t2,number=number
n1=n_elements(evc(*,0))
w1=where(trb(5,*) eq t1)
pos1=trb(*,w1)
w2=where(trb(5,*) eq t2)
pos2=trb(*,w2)
ckt01=ckt1(pos1,pos2,evc)
evc01=fltarr(1,n1)
for j=0,number-1 do begin
evc01=evc01+evc(*,ckt01(0,j))*ckt01(2,j)
endfor
a0=total(ckt01(1,0:number-1))
print,a0
pos001=reform(evc01,2,n1/2)
rd01=findgen(6,n1/2)
rd01(0:1,*)=pos1(0:1,*)
rd01(2:3,*)=pos2(0:1,*)-pos1(0:1,*)
rd01(4:5,*)=pos001
return,rd01
end
