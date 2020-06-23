number=20
bines=0.25

str=jqwtr
slo=jqwlo
omg01=1./sqrt(abs(evs01(0:1999)))
h01=histogram(omg01,binsize=bines,locations=loc,min=0.0)
strw1=findgen(64,number)
slow1=findgen(64,number)
for i=0,number-1 do begin
w=where(omg01 gt loc[i] and omg01 le loc[i+1])
print,i
stra=str(*,w)
sloa=slo(*,w)
strb=rebin(stra,64,1)
slob=rebin(sloa,64,1)
print,h01[i]
strw1(*,i)=strb
slow1(*,i)=slob
endfor
jqwtr1=strw1
jqwlo1=slow1
end