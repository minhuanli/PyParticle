Pro dispersionsqomg1,evs,str,slo,sqwtr,sqwlo,number=number
omg01=1./sqrt(abs(evs(0:number-1)))
for j=0,number-1 do begin
str(*,j)=str(*,j)/(omg01[j])^2
slo(*,j)=slo(*,j)/(omg01[j])^2
endfor
sqwtr=str
sqwlo=slo
end
