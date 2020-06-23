pro sqomg1,evs,evc,pos,sqwtr,sqwlo,number=number
dtr01=findgen(number,256)
dlo01=findgen(number,256)
for j=0,number-1 do begin
d01=evc(*,j)
vecprj4,d01,pos,tr,lo,qtr,qlo,bins=512
dtr02=qtr(1,0:255)
dlo02=qlo(1,0:255)
dtr01(j,*)=dtr02
dlo01(j,*)=dlo02
endfor
str=transpose(dtr01)
slo=transpose(dlo01)
omg01=1./sqrt(abs(evs(0:number-1)))
for i=0,number-1 do begin
str(*,i)=str(*,i)/(omg01[i])^2
slo(*,i)=slo(*,i)/(omg01[i])^2
endfor
sqwtr=str
sqwlo=slo
end
