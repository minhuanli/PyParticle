;f1 is W6'; f2 is q4 index; f3 is w4 index
;result is the ratio of bcc,hcp,and fcc 
function strrat_revised,datavoi=datavoi,dataspt=dataspt,f1=f1,f2=f2,f3=f3,bcc=bcc,hcp=hcp,fcc=fcc
result=fltarr(3,1)
nw=n_elements(datavoi(0,*))
w1=where(datavoi(f1,*) gt 0,nw1)
b0x=dataspt[f2,*]-0.1275001
b0y=dataspt[f3,*]+0.2
b0k=b0y/b0x
w3=where(datavoi[f1,*] lt 0 and b0x gt 0 and b0k lt 0.4/0.1225,nw3)
w21=where(datavoi[f1,*] lt 0 and b0k gt 0.4/0.1225,nw21)
w22=where(datavoi[f1,*] lt 0 and  b0x le 0,nw22)
w2=[w21,w22]
nw2=nw21+nw22

result(0)=float(nw1)/float(nw)
result(1)=float(nw2)/float(nw)
result(2)=float(nw3)/float(nw)

bcc=dataspt(*,w1)
hcp=dataspt(*,w2)
fcc=dataspt(*,w3)

return,result

end
