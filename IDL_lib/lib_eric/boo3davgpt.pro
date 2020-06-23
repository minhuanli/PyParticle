pro boo3davgpt,pta,boo,boot,dr=dr
n1=n_elements(pta(0,*))
boo=fltarr(13,n1)
boo([0,1,2,12],*)=pta([0,1,2,7],*)
t1=max(pta(7,*))-min(pta(7,*))
t2=min(pta(7,*))+findgen(t1+1)
boot=findgen(5,t1+1)
for i=0,t1 do begin
w=where(pta(7,*) eq t2[i])
b01=boo3davgg(pta(*,w),bondmax=12.0,deltar=dr)
print,t2[i]
boo(3:11,w)=b01(0:8,*)
boot(0,i)=t2[i]
boot(1,i)=mean(b01(5,*))
boot(2,i)=variance(b01(5,*))
boot(3,i)=mean(b01(6,*))
boot(4,i)=variance(b01(6,*))
endfor
end