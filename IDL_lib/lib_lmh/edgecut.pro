function edgecut,data,dc=dc
 if not(keyword_set(dc)) then dc=5.
 max1=max(data(0,*))-dc
 may1=max(data(1,*))-dc
 maz1=max(data(2,*))-dc
 mix1=min(data(0,*))+dc
 miy1=min(data(1,*))+dc
 miz1=min(data(2,*))+dc
 w=where(data(0,*) gt mix1 and data(0,*) lt max1 and data(1,*) gt miy1 and data(1,*) lt may1 and data(2,*) gt miz1 and data(2,*) lt maz1)
 ndata=data(*,w)
 
return,ndata

end
