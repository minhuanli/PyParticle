;1,bcc,2,fcc+hcp,3,fcc,4,hcp,5,mrco,6,bcc mrco,7,fcc mrco,8 hcp mrco,precursors are defined as low bond number and high Q6
function fccboo3dnew_revised,boo,abcc=abcc,bfcc=bfcc,chcp=chcp,dbccmicro=dbccmicro,efccmicro=efccmicro,fhcpmicro=fhcpmicro
n1=max(boo(15,*))-min(boo(15,*))
f01=fltarr(11,n1+1)
abcc=make_array(300000,n1+1,/long,value=-1)
bfcc=make_array(200000,n1+1,/long,value=-1)
chcp=make_array(200000,n1+1,/long,value=-1)
dbccmicro=make_array(300000,/long,n1+1,value=-1)
efccmicro=make_array(200000,/long,n1+1,value=-1)
fhcpmicro=make_array(200000,/long,n1+1,value=-1)
;nuclei=make_array(100000,n1+1,value=-1) 
;micro=make_array(100000,n1+1,value=-1)
ta=min(boo(15,*))+findgen(n1+1)
f01(0,*)=ta
print,'1,bcc,2,fcc+hcp,3,fcc,4,hcp,5,mrco,6,bcc mrco,7,fcc mrco,8 hcpmrco,9 solid percentage,10 pure liq'
for j=0,n1 do begin
print,j
w=where(boo(15,*) eq ta[j],nbb)
;b01=boo(*,w)
w1=where(boo(15,*) eq ta[j] and boo(3,*) gt 6 and boo[14,*] gt 11,naa)
if naa gt 0 then begin
;b001=b01(*,w1)
;w11=where(b001(14,*) gt 13, na)
w11=where(boo(15,*) eq ta[j] and boo(3,*) gt 6 and boo[14,*] gt 13, na)
abcc[0:na-1,j]=w11
w12=where(boo(15,*) eq ta[j] and boo(3,*) gt 6 and boo[14,*] lt 13 and boo[14,*] gt 11, nb)
if nb gt 0 then begin
;b002=b001(*,w12)
;b0x=b002(8,*)-0.1275
;b0y=b002(10,*)+0.2
b0x=boo[8,*]-0.1275001
b0y=boo[10,*]+0.2
b0z=b0y/b0x
w13=where(boo[15,*] eq ta[j] and boo(3,*) gt 6 and boo[14,*] lt 13 and boo[14,*] gt 11 and b0x gt 0 and b0z lt 0.4/0.1225,nc)
bfcc[0:nc-1,j]=w13
;w133=where(b0x ne b0x[w13],ndd)
w133=subset(w12,w13,setnumber=ndd)
chcp[0:ndd-1,j]=w133
nd=nb-nc
endif else begin
nc=0
nd=0
endelse
;w14=where(b01(3,*) le 7.0 and b01(5,*) gt 0.27 and b01(14,*) gt 11, ncc);;;;
;w15=where(b01(3,*) le 7.0 and b01(5,*) gt 0.27 and b01(14,*) gt 13, ncc1);;;;;
w14=where(boo[15,*] eq ta[j] and boo[3,*] le 6.0 and boo[5,*] gt 0.27 and boo[14,*] gt 11, ncc)
w15=where(boo[15,*] eq ta[j] and boo[3,*] le 6.0 and boo[5,*] gt 0.27 and boo[14,*] gt 13, ncc1)
dbccmicro[0:ncc1-1,j]=w15
w16=where(boo[15,*] eq ta[j] and boo(3,*) le 6.0 and boo(5,*) gt 0.27 and boo(14,*) lt 13 and boo(14,*) gt 11, ncc2);;;;
if ncc2 gt 0 then begin
;c002=b01(*,w16)
;b00x=c002(8,*)-0.1275
;b00y=c002(10,*)+0.2
b00x=boo(8,*)-0.1275001
b00y=boo(10,*)+0.2
b00z=b00y/b00x
;w17=where(b00x gt 0 and b00z lt 0.4/0.1225,ncc3)
w17=where(boo[15,*] eq ta[j] and boo[3,*] le 6.0 and boo[5,*] gt 0.27 and boo[14,*] lt 13 and boo[14,*] gt 11 and b00x gt 0 and b0z lt 0.4/0.1225,ncc3)
efccmicro[0:ncc3-1,j]=w17
;w177=where(b00x ne b0x[w17],nccc3)
w177=subset(w16,w17,setnumber=nccc3)
fhcpmicro[0:nccc3-1,j]=w177
ncc4=ncc2-ncc3
endif else begin
ncc3=0
ncc4=0
endelse
f01(1,j)=1.0*na/naa
f01(2,j)=1.0*nb/naa
f01(3,j)=1.0*nc/naa
f01(4,j)=1.0*nd/naa
f01(5,j)=1.0*ncc/nbb
f01(6,j)=1.0*ncc1/ncc
f01(7,j)=1.0*ncc3/ncc
f01(8,j)=1.0*ncc4/ncc
f01(9,j)=1.0*naa/nbb
f01(10,j)=1.0-f01(9,j)-f01(5,j)
endif
endfor
return,f01
end
