pro jqomg,evs,evc,pos,trall,loall,jqwtr,jqwlo,number=number,bines=bines
dtr01=findgen(2000,64)
dlo01=findgen(2000,64)
for j=0,1999 do begin
d01=evc(*,j)
vecprj4,d01,pos,tr,lo,qtr,qlo,bins=128
dtr02=qtr(1,0:63)
dlo02=qlo(1,0:63)
dtr01(j,*)=dtr02
dlo01(j,*)=dlo02
endfor
str=transpose(dtr01)
slo=transpose(dlo01)
omg01=1./sqrt(abs(evs(0:1999)))
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
trall=dtr01
loall=dlo01
jqwtr=strw1
jqwlo=slow1
end
