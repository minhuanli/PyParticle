;,0 solid bond number,1 bcc percentage,2 fcc percentage,3,hcp percentage,4,bcc density,5,fcc density,
;6,hcp density,
function fccbond3d,data
b1=transpose(data(3,*))
b11=b1[uniq(b1,sort(b1))]
n1=n_elements(b11)
f01=fltarr(7,n1)
for j=0,n1-1 do begin
w=where(data(3,*) eq b11[j],na)
data1=data(*,w)
if na gt 0 then begin
endif
w1=where(data1(14,*) gt 13,nbcc)
f01(4,j)=mean(data1(12,w1))
w2=where(data1(14,*) lt 13,nfhcp)
if nfhcp gt 0 then begin
data2=data1(*,w2)
b0x=data2(8,*)-0.1
b0y=data2(10,*)+0.2
b0z=b0y/b0x
w13=where(b0x gt 0 and b0z lt 0.4/0.15,nfcc)
nhcp=nfhcp-nfcc
f01(2,j)=nfcc*1.0/na
f01(5,j)=mean(data2(12,w13))
f01(3,j)=nhcp*1.0/na
f01(6,j)=(total(data2(12,*))-total(data2(12,w13)))/nhcp
endif
f01(1,j)=nbcc*1.0/na
f01(0,j)=b11[j]
endfor
return,f01
end
