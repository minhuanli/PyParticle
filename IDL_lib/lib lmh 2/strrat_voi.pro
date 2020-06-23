;f1 is W6 index; f2 is W4 index
;result is the ratio of bcc,hcp,and fcc 
function strrat_voi,data,f1=f1,f2=f2,bcc=bcc,hcp=hcp,fcc=fcc
result=fltarr(3,1)
nw=n_elements(data(0,*))

w1=where(data(f1,*) gt 0,nw1)
w2=where(data(f1,*) lt 0 and data(f2,*) gt 0,nw2)
w3=where(data(f1,*) lt 0 and data(f2,*) lt 0,nw3)

if nw1 eq 0 then result(0)=0 else result(0)=float(nw1)/float(nw)
if nw2 eq 0 then result(1)=0 else result(1)=float(nw2)/float(nw)
if nw3 eq 0 then result(2)=0 else result(2)=float(nw3)/float(nw)

if nw1 eq 0 then bcc=[-1] else bcc=data(*,w1)
if nw2 eq 0 then hcp=[-1] else hcp=data(*,w2)
if nw3 eq 0 then fcc=[-1] else fcc=data(*,w3)

return,result

end
