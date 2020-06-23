;f1 is bond number index; f2 is q4 index; f3 is w4 index
;result is the ratio of bcc,hcp,and fcc 
function strrat,data,f1=f1,f2=f2,f3=f3,bcc=bcc,hcp=hcp,fcc=fcc
result=fltarr(3,1)
nw=n_elements(data(0,*))
w1=where(data(f1,*) gt 13,nw1)
b0x=data[f2,*]-0.1275001
b0y=data[f3,*]+0.2
b0k=b0y/b0x
w3=where(data[f1,*] lt 13 and b0x gt 0 and b0k lt 0.4/0.1225,nw3)
w21=where(data[f1,*] lt 13 and b0k gt 0.4/0.1225,nw21)
w22=where(data[f1,*] lt 13 and b0x le 0,nw22)
w2=[w21,w22]
nw2=nw21+nw22

result(0)=float(nw1)/float(nw)
result(1)=float(nw2)/float(nw)
result(2)=float(nw3)/float(nw)

if nw1 eq 0 then bcc=[-1] else bcc=data(*,w1)
if nw2 eq 0 then hcp=[-1] else hcp=data(*,w2)
if nw3 eq 0 then fcc=[-1] else fcc=data(*,w3)

return,result

end
