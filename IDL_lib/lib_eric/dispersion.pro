;计算S(q,wm),没除w
pro dispersion,evc,pos,str,slo,number=number,nbins=nbins
b01=nbins/2-1
dtr01=findgen(number,b01+1)
dlo01=findgen(number,b01+1)
for j=0,number-1 do begin
d01=evc(*,j)
vecprj2,d01,pos,tr,lo,qtr,qlo,bins=nbins
dtr02=qtr(1,0:b01)
dlo02=qlo(1,0:b01)
dtr01(j,*)=dtr02
dlo01(j,*)=dlo02
endfor
str=transpose(dtr01)
slo=transpose(dlo01)
end