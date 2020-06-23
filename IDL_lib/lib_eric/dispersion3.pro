;计算j(q,w),不乘q^2,不除w
pro dispersion3,evs,evc,pos,strw,slow,number=number,bins=bins
for j=0,1999 do begin
d01=evc(*,j)
dtr01=findgen(2000,64)
dlo01=findgen(2000,64)
vecprj3,d01,pos,tr,lo,qtr,qlo,bins=128
dtr02=qtr(1,0:63)
dlo02=qlo(1,0:63)
dtr01(j,*)=dtr02
dlo01(j,*)=dlo02
endfor
str=transpose(dtr01)
slo=transpose(dlo01)
n1=n_elements(str(*,0))
omg01=1./sqrt(abs(evs(0:1999)))
h01=histogram(omg01,binsize=bins,locations=lo,min=0)
strw1=findgen(n1,number)
slow1=findgen(n1,number)
for i=0,number-1 do begin
w=where(omg01 gt lo[i] and omg01 le lo[i+1])
stra=str(*,w)
sloa=slo(*,w)
strb=rebin(stra,n1,1)
slob=rebin(sloa,n1,1)
print,h01[i]
strw1(*,i)=strb
slow1(*,i)=slob
endfor
strw=strw1
slow=slow1
end

