function fccboo3ddensity,boo
n1=max(boo(15,*))-min(boo(15,*))
f01=fltarr(5,n1+1)
ta=min(boo(15,*))+findgen(n1+1)
f01(0,*)=ta
;print,'1,bcc,2,fcc+hcp,3,fcc,4,hcp,5,mrco,6,bcc mrco,7,fcc mrco,8 hcpmrco'
for j=0,n1 do begin
w=where(boo(15,*) eq ta[j],nbb)
b01=boo(*,w) 
ww=where(b01(12,*) gt 0)
rou0=1./mean(b01(12,ww))
w1=where(b01(12,*) gt 0 and b01(14,*) gt 13, nc)
rou1=1./mean(b01(12,w1))
w2=where(b01(12,*) gt 0 and b01(14,*) gt 11 and b01(14,*) lt 13,nd)
rou2=1./mean(b01(12,w2))
f01(1,j)=1.*nd/nc
f01(2,j)=rou1
f01(3,j)=rou2
f01(4,j)=rou0
endfor
return,f01
end