;return number of fcc or bcc contains in each cluster. cluster size (0,*), 
;bcc number/fcc+hcp number (1,*), bcc number (2,*), fcchcp number (3,*), total number (4,*)
pro crystalbin,boo,solid=solid,mrco=mrco
w=where(boo(3,*) ge 7.0)
b02=boo(*,w)
;b01=clusterbin(b02,deltar=deltar)
b01=b02
id1=b01(16,*)
id2=transpose(id1[uniq(id1,sort(id1))])
na=n_elements(id2)
f01=fltarr(8,na)
for j=0,na-1 do begin
w1=where(b01(16,*) eq id2(0,j),nb)
if nb gt 0 then begin
b03=b02(*,w1)
w2=where(b03(14,*) gt 13, nbcc)
f01(1,j)=nbcc*1.0/nb
f01(5,j)=mean(b03(12,w2))
w3=where(b03(14,*) lt 13, nfhcp)
if nfhcp gt 0 then begin
data2=b03(*,w3)
b0x=data2(8,*)-0.1
b0y=data2(10,*)+0.2
b0z=b0y/b0x
w13=where(b0x gt 0 and b0z lt 0.4/0.15,nfcc)
nhcp=nfhcp-nfcc
f01(2,j)=nfcc*1.0/nb
f01(6,j)=mean(data2(12,w13))
f01(3,j)=nhcp*1.0/nb
f01(7,j)=(total(data2(12,*))-total(data2(12,w13)))/nhcp
f01(4,j)=nb
endif
endif
endfor
w=where(boo(3,*) lt 7.0 and boo(5,*) gt 0.27)
b02=boo(*,w)
;b01=clusterbin(b02,deltar=deltar)
b01=b02
id1=b01(16,*)
id22=transpose(id1[uniq(id1,sort(id1))])
na=n_elements(id22)
f001=fltarr(8,na)
for j=0,na-1 do begin
w1=where(b01(16,*) eq id22(0,j),nb)
if nb gt 0 then begin
b03=b02(*,w1)
w2=where(b03(14,*) gt 13, nbcc)
f001(1,j)=nbcc*1.0/nb
f001(5,j)=mean(b03(12,w2))
w3=where(b03(14,*) lt 13, nfhcp)
if nfhcp gt 0 then begin
data2=b03(*,w3)
b0x=data2(8,*)-0.1
b0y=data2(10,*)+0.2
b0z=b0y/b0x
w13=where(b0x gt 0 and b0z lt 0.4/0.15,nfcc)
nhcp=nfhcp-nfcc
f001(2,j)=nfcc*1.0/nb
f001(6,j)=mean(data2(12,w13))
f001(3,j)=nhcp*1.0/nb
f001(7,j)=(total(data2(12,*))-total(data2(12,w13)))/nhcp
f001(4,j)=nb
endif
endif
endfor
f01(0,*)=id2
f001(0,*)=id22
solid=f01
mrco=f001
end

