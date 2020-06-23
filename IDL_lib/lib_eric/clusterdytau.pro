;project dynamics of time interval dt to modes, (0,*) is probability of each mode, (1,*) is cululative sorted.
pro clusterdytau,trb,maxcluster,ncluster,percent=percent,deltar=deltar,dt=dt
;n1=n_elements(evc(*,0))-2
;s1=size(trb)
ta=trb(5,*)
taa=min(ta)
tb=max(ta)-taa
tc=taa+findgen(tb)
td=tb-dt
c02=fltarr(2,td+1)
n11=0
n12=0
for j=0,td do begin
t11=tc[j]
t22=t11+dt
c01=clusterdy(trb,t1=t11,t2=t22,percent=percent,deltar=deltar)
;print,j
c02(0,j)=max(c01(0,*))
c02(1,j)=max(c01(1,*))
n11=[n11,transpose(c01(0,*))]
n12=[n12,transpose(c01(1,*))]
endfor
maxcluster=c02
naa=n_elements(n11)
ncluster=fltarr(2,naa-1)
ncluster(0,*)=transpose(n11[1:naa-1])
ncluster(1,*)=transpose(n12[1:naa-1])
end

