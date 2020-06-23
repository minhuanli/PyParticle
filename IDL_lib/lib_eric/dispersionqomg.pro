Pro dispersionsqomg,evs,str,slo,sqwtr,sqwlo,number=number,bines=bines
omg01=1./sqrt(abs(evs(0:1999)))
h01=histogram(omg01,binsize=bines,locations=loc,min=0.0)
n1=n_elements(str(*,0))
strw1=findgen(n1,number)
slow1=findgen(n1,number)
for i=0,number-1 do begin
w=where(omg01 gt loc[i] and omg01 le loc[i+1])
stra=str(*,w)
sloa=slo(*,w)
strb=rebin(stra,n1,1)
slob=rebin(sloa,n1,1)
omg02=mean(omg01[w])
print,h01[i]
strw1(*,i)=strb/omg02^2
slow1(*,i)=slob/omg02^2
endfor
sqwtr=strw1
sqwlo=slow1
end
