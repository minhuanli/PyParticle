function omgtaulgbin,omgtau,evs
n1=n_elements(omgtau(*,0))
n2=n_elements(omgtau(0,*))
omg1=1./sqrt(abs(evs(0:n2-2)))
omg2=round(omg1/min(omg1))
;omg3=omg2(uniq(omg2,sort(omg2)))
;omg33=uniq(omg2,sort(omg2))
a1=1.15^findgen(100)
a2=round(a1)
a3=a2(uniq(a2,sort(a2)))
w=where(a3 lt max(omg2),naa)
a3=a3[w]
tau1=fltarr(n1,naa)
for j=0,naa-1 do begin
w1=where(omg2 eq a3[j],nab)
print,a3[j]
if nab gt 0 then begin
;print,omg3[w1]
id1=w1+1
b11=rebin(omgtau(*,omg2[id1]),n1,1)
tau1(*,j)=smooth(b11,5)
endif
endfor
w2=where(tau1(0,*) ne 0)
tau1=tau1(*,w)
return,tau1
end


