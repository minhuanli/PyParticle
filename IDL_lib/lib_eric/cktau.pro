;project dynamics of time interval dt to modes, (0,*) is probability of each mode, (1,*) is cululative sorted.
function cktau,trb,evc,dt=dt,average=average
n1=n_elements(evc(0,*))
s1=size(trb)
ta=trb(5,*)
taa=min(ta)
tb=max(ta)-taa
tc=taa+findgen(tb)
td=tb-dt
c02=fltarr(average,n1)
c002=fltarr(average,n1)
for j=0,average-1 do begin
t11=tc[j]
t22=t11+dt
c01=ckt(trb,evc,t1=t11,t2=t22)
;print,j
c02(j,*)=c01(1,*)
c002(j,*)=total(c01(1,reverse(sort(c01(1,*)))),/cumulative)
endfor
c03=fltarr(2,n1)
c03(0,*)=rebin(c02,1,n1)
c03(1,*)=rebin(c002,1,n1)
return,c03
end

