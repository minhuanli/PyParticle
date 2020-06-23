;1,nuclei,2,bcc,3,12 bond,4,mrco,5,14 mrco,6,12,mrco,7,fcc,8,fccmrco
function fccboo3drho,boo
n1=max(boo(15,*))-min(boo(15,*))
f01=fltarr(9,n1+1)
ta=min(boo(15,*))+findgen(n1+1)
f01(0,*)=ta
print,'1,bcc,2,fcc+hcp,3,fcc,4,hcp,5,mrco,6,bcc mrco,7,fcc mrco,8 hcpmrco'
for j=0,n1 do begin
w=where(boo(15,*) eq ta[j],nbb)
b01=boo(*,w)
w1=where(b01(3,*) ge 7.0,naa)
if naa gt 0 then begin
rho1=1./mean(b01(12,w1))
b001=b01(*,w1)
w11=where(b001(14,*) gt 13, na)
rho2=1./mean(b001(12,w11))
w12=where(b001(14,*) lt 13, nb)
if nb gt 0 then begin
b002=b001(*,w12)
b0x=b002(8,*)-0.1
b0y=b002(10,*)+0.2
b0z=b0y/b0x
w13=where(b0x gt 0 and b0z lt 0.4/0.15,nc)
rho3=1./mean(b001(12,w12))
rho7=1./mean(b002(12,w13))
nd=nb-nc
endif else begin
nc=0
nd=0
endelse
w14=where(b01(3,*) le 6.0 and b01(5,*) gt 0.27 and b01(14,*) gt 11, ncc)
w15=where(b01(3,*) le 6.0 and b01(5,*) gt 0.27 and b01(14,*) gt 13, ncc1)
w16=where(b01(3,*) le 6.0 and b01(5,*) gt 0.27 and b01(14,*) lt 13 and b01(14,*) gt 11, ncc2)
if ncc2 gt 0 then begin
rho4=1./mean(b01(12,w14))
rho5=1./mean(b01(12,w15))
rho6=1./mean(b01(12,w16))
c002=b01(*,w16)
b00x=c002(8,*)-0.1
b00y=c002(10,*)+0.2
b00z=b00y/b00x
w17=where(b00x gt 0 and b00z lt 0.4/0.15,ncc3)
rho8=1./mean(c002(12,w17))
ncc4=ncc2-ncc3
endif else begin
ncc3=0
ncc4=0
endelse
f01(1,j)=rho1
f01(2,j)=rho2
f01(3,j)=rho3
f01(4,j)=rho4
f01(5,j)=rho5
f01(6,j)=rho6
f01(7,j)=rho7
f01(8,j)=rho8
endif
endfor
wv=where(boo(12,*) gt 0)
f01(1:7,*)=f01(1:7,*)*mean(boo(12,wv))
return,f01
end
