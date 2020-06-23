function clustermodesbin,clustera,evs
n1=n_elements(clustera(0,*))
omg1=1./sqrt(abs(evs(0:n1-1)))
omg2=round(omg1/min(omg1))
;omg2=omg2(uniq(omg2,sort(omg2)))
;omg22=uniq(omg2,sort(omg2))
a1=round(1.15^findgen(100))
a1=a1(uniq(a1,sort(a1)))
w=where(a1 lt max(omg2),nc)
a1=a1[w]
cluster1=fltarr(3,nc)
for j=0,nc-1 do begin
w=where(omg2 eq a1[j],nd)
if nd gt 0 then begin
id1=w
cluster1(0,j)=min(omg1)*a1[j]
cluster1(1,j)=mean(clustera(0,omg2[id1]))
cluster1(2,j)=mean(clustera(1,omg2[id1]))
endif
endfor
w=where(cluster1(1,*) ne 0)
cluster1=cluster1(*,w)
return,cluster1
end