pro clusterdytr,trb,cluster1,cluster2,percent=percent,deltar=deltar
a1=1.15^findgen(100)
tmax=max(trb(5,*))-min(trb(5,*))
w=where(a1 lt tmax)
ta=round(a1[w])
tb=ta(uniq(ta,sort(ta)))
n1=n_elements(tb)
b11=fltarr(2,n1)
b12=[0,0,0]
for j=0,n1-1 do begin
taa=tb[j]
print,taa
clusterdytau,trb,maxcluster,ncluster,percent=percent,deltar=deltar,dt=taa
b11(0,j)=mean(maxcluster(0,*))
b11(1,j)=mean(maxcluster(1,*))
na=n_elements(ncluster(0,*))
tab=fltarr(1,na)+taa
ncluster1=[ncluster,tab]
b12=[[b12],[ncluster1]]
endfor
cluster1=[transpose(tb),b11]
nb=n_elements(b12(0,*))
cluster2=b12(*,1:nb-1)
end