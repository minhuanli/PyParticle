;compute all fraction of all symmetries
function fccboo3dall,boo,tetra1
n1=max(boo(15,*))-min(boo(15,*))
f01=fltarr(13,n1+1)
ta=min(boo(15,*))+findgen(n1+1)
f01(0,*)=ta
print,'1,all crystal,2,all precursor,3,all frustrated tetra
boo=symmetry(boo)
for j=0,n1 do begin
w=where(boo(15,*) eq ta[j],nbb)
b01=boo(*,w)
t01=tetra1(*,w)
wa=where(b01(3,*) ge 7.0 and b01(13,*) gt 0,na)
wb=where(b01(3,*) lt 7.0 and b01(5,*) gt 0.25 and b01(13,*) gt 0,naa)
wc=where(t01(4,*) gt 10 and b01(13,*) gt 0,nc)
w1=where(b01(3,*) ge 7.0 and b01(13,*) eq 1,n11)
w2=where(b01(3,*) ge 7.0 and b01(13,*) eq 2,n22)
w3=where(b01(3,*) ge 7.0 and b01(13,*) eq 3,n33)
w11=where(b01(3,*) lt 7.0 and b01(5,*) gt 0.25 and b01(13,*) eq 1,n111)
w22=where(b01(3,*) lt 7.0 and b01(5,*) gt 0.25 and b01(13,*) eq 2,n222)
w33=where(b01(3,*) lt 7.0 and b01(5,*) gt 0.25 and b01(13,*) eq 3,n333)
w111=where(t01(4,*) gt 10 and b01(5,*) lt 0.25 and b01(13,*) eq 1,n1)
w111=where(t01(4,*) gt 10 and b01(5,*) lt 0.25 and b01(13,*) eq 2,n2)
w111=where(t01(4,*) gt 10 and b01(5,*) lt 0.25 and b01(13,*) eq 3,n3)
f01(1,j)=1.0*na/nbb
f01(2,j)=1.0*naa/nbb
f01(3,j)=1.0*nc/nbb
f01(4,j)=1.0*n11/nbb
f01(5,j)=1.0*n22/nbb
f01(6,j)=1.0*n33/nbb
f01(7,j)=1.0*n111/nbb
f01(8,j)=1.0*n222/nbb
f01(9,j)=1.0*n333/nbb
f01(10,j)=1.0*n1/nbb
f01(11,j)=1.0*n2/nbb
f01(12,j)=1.0*n3/nbb
endfor
return,f01
end
