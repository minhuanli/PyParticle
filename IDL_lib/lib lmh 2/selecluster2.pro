;select a certain size cluster
;nb is the cluster index
function selecluster2,data,c01=c01,nb=nb
n=n_elements(nb)
da=c01(*,nb(0))
w=where(da gt 0)
temp=data(*,w)
if n gt 1 then begin
  for i=1,n-1 do begin
   da=c01(*,nb(i))
   w=where(da gt 0)
   temp1=data(*,w)
   temp=[[temp],[temp1]]
  endfor
endif

return,temp

end