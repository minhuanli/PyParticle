;计算S(q,w),除了w,乘了q^2
pro dispersion2,evs,evc,pos,strw,slow,number=number,bins=bins
dispersion,evc,pos,str,slo,number=2000,nbins=128
n1=n_elements(str(*,0))
omg01=1./sqrt(abs(evs(0:1999)))
h01=histogram(omg01,binsize=bins,locations=lo,min=0)
strw1=findgen(n1,number)
slow1=findgen(n1,number)
for j=0,number-1 do begin
w=where(omg01 gt lo[j] and omg01 le lo[j+1])
stra=str(*,w)
sloa=slo(*,w)
strb=rebin(stra,n1,1)
slob=rebin(sloa,n1,1)
strb=strb/mean(omg01(w))
print,mean(omg01(w))
slob=slob/mean(omg01(w))
strw1(*,j)=strb
slow1(*,j)=slob
endfor
strw=strw1
slow=slow1
end