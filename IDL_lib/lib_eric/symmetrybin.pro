pro symmetrybin, boo,bcc=bcc,fcc=fcc,hcp=hcp
b01=boo
w1=where(b01(14,*) gt 13)
b201=b01(*,w1)
a01=avgbin(b201(3,*),b201(8,*),binsize=0.1)
a02=avgbin(b201(3,*),b201(9,*),binsize=0.1)
c01=avgbin(b201(3,*),b201(10,*),binsize=0.1)
c02=avgbin(b201(3,*),b201(11,*),binsize=0.1)
a03=avgbin(b201(3,*),mean(b01(12,*))/b201(12,*),binsize=0.1)
w2=where(b01(14,*) gt 11 and b01(14,*) lt 13)
b202=b01(*,w2)
b0x=b202(8,*)-0.1
b0y=b202(10,*)+0.2
b0z=b0y/b0x
w3=where(b0x gt 0 and b0z lt 0.4/0.15)
b203=b202(*,w3)
aa01=avgbin(b203(3,*),b203(8,*),binsize=0.1)
aa02=avgbin(b203(3,*),b203(9,*),binsize=0.1)
cc01=avgbin(b203(3,*),b203(10,*),binsize=0.1)
cc02=avgbin(b203(3,*),b203(11,*),binsize=0.1)
aa03=avgbin(b203(3,*),mean(b01(12,*))/b203(12,*),binsize=0.1)
w4=where(b0x le 0 or b0z ge 0.4/0.15)
b204=b202(*,w4)
aaa01=avgbin(b204(3,*),b204(8,*),binsize=0.1)
aaa02=avgbin(b204(3,*),b204(9,*),binsize=0.1)
ccc01=avgbin(b204(3,*),b204(10,*),binsize=0.1)
ccc02=avgbin(b204(3,*),b204(11,*),binsize=0.1)
aaa03=avgbin(b204(3,*),mean(b01(12,*))/b204(12,*),binsize=0.1)
bcc=[a01(0:2,*),a02(1:2,*),c01(1:2,*),c02(1:2,*),a03(1:2,*)]
fcc=[aa01(0:2,*),aa02(1:2,*),cc01(1:2,*),cc02(1:2,*),aa03(1:2,*)]
hcp=[aaa01(0:2,*),aaa02(1:2,*),ccc01(1:2,*),ccc02(1:2,*),aaa03(1:2,*)]
end


