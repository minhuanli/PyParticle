pro clusterdymodes,pos,evc,cluster1,cluster2,percent=percent,deltar=deltar
n1=n_elements(evc(*,0))
n2=n_elements(evc(0,*))
cluster2=[0,0,0]
cluster1=fltarr(2,n2)
for j=0,n2-1 do begin
;print,j
e01=reform(evc(*,j),2,n1/2)
dr2=e01(0,*)^2+e01(1,*)^2
id1=reverse(sort(dr2))
na=round(percent*n1/2.0)
id2=id1[0:na-1]
pos01=pos(*,id2)
idcluster2d,pos01,deltar=deltar,list=csize
cluster1(0,j)=mean(csize(0,*))
cluster1(1,j)=mean(csize(1,*))
nb=n_elements(csize(0,*))
ida=fltarr(1,nb)+j
csize1=[csize,ida]
cluster2=[[cluster2],[csize1]]
endfor
nc=n_elements(cluster2(0,*))
cluster2=cluster2(*,1:nc-1)
end
