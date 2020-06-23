;idcenter every patch as a point
;n is patch number, for fcc cluster, the cluster number 18
;the output is every patch's center's position
;the output is sorted from larger patch to smaller ones
function idcenter_all, pjdata=pjdata, c01=c01, s01=s01, np=np
temp=fltarr(3,np)
w=reverse(sort(s01(0,*)))

for i=0,np-1 do begin
  temppatch=selecluster2(pjdata,c01=c01,nb=w(i))
  temp(*,i)=idcenter(temppatch)
endfor

return,temp

end