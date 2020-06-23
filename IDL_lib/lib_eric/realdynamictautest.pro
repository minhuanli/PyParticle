;ck1 is the projection of dt dynamics on each mode, ck1(*,0) coutains the time interval,ck2 is cumulative,ck2(*,0) coutains the time interval dt, 
pro realdynamictautest,trb,evc,ck1
naa=n_elements(evc(0,*))
a1=1.15^findgen(100)
tmax=max(trb(5,*))-min(trb(5,*))
w=where(a1 lt tmax)
ta=round(a1[w])
tb=ta(uniq(ta,sort(ta)))
n1=n_elements(tb)
ck1=fltarr(n1,naa+1)
ck2=fltarr(n1,naa+1)
ck1(*,0)=tb
ck2(*,0)=tb
for j=0,n1-1 do begin
taa=tb[j]
print,taa
c01=cktautest(trb,evc,dt=taa)
ck1(j,1:naa)=c01(0,*)
endfor
end
