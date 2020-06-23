function trlointensity,ftr,flo,evs,number=number,scale=scale,smoo=smoo
n1=n_elements(ftr(0,*))
ftr1=ftr(0:number-1,*)
flo1=flo(0:number-1,*)
tr1=findgen(5,n1)
for i=0,number-1 do begin
ftr1(i,*)=ftr1(i,*)*(i+1)
flo1(i,*)=flo1(i,*)*(i+1)
endfor

for j=0,n1-1 do begin
a1=max(ftr1(*,j))
a2=mean(ftr1(*,j))
b1=max(flo1(*,j))
b2=mean(flo1(*,j))
tr1(1,j)=a1
tr1(2,j)=a2
tr1(3,j)=b1
tr1(4,j)=b2
endfor
omg1=1./sqrt(evs(0:n1-1))
tr1(0,*)=omg1
tr2=findgen(5,1800/scale)
tr2(0,*)=rebin(tr1(0,0:1799),1,1800/scale)
tr2(1,*)=rebin(tr1(1,0:1799),1,1800/scale)
tr2(2,*)=rebin(tr1(2,0:1799),1,1800/scale)
tr2(3,*)=rebin(tr1(3,0:1799),1,1800/scale)
tr2(4,*)=rebin(tr1(4,0:1799),1,1800/scale)
tr2(0,*)=smooth(tr2(0,*),smoo)
tr2(1,*)=smooth(tr2(1,*),smoo)
tr2(2,*)=smooth(tr2(2,*),smoo)
tr2(3,*)=smooth(tr2(3,*),smoo)
tr2(4,*)=smooth(tr2(4,*),smoo)
return,tr2
end

