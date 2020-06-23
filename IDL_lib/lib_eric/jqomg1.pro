pro jqomg1,evs,evc,pos,jqwtr,jqwlo,number=number
dtr01=findgen(number,64)
dlo01=findgen(number,64)
for j=0,number-1 do begin
d01=evc(*,j)
vecprj4,d01,pos,tr,lo,qtr,qlo,bins=128
dtr02=qtr(1,0:63)
dlo02=qlo(1,0:63)
dtr01(j,*)=dtr02
dlo01(j,*)=dlo02
endfor
str=transpose(dtr01)
slo=transpose(dlo01)
omg01=1./sqrt(abs(evs(0:number-1)))
jqwtr=str
jqwlo=slo
end
