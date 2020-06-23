;select all the clusters whose sizes are larger than a certain cutoff
function selecluster, data=data, c01=c01, s01=s01, sc=sc
w=where(s01(0,*) ge sc)
stemp=s01(*,w) 
n=n_elements(stemp(1,*))

for i=0, n-1 do begin 
  a=stemp(0,i)
  b=stemp(1,i)
  w=where(s01(0,*) eq a and s01(1,*) eq b)
  da=c01(*,w)
  w=where(da gt 0)
  ctemp=data(*,w)
   if (i eq 0) then begin
   csum=ctemp
   endif else begin
   csum=[[csum],[ctemp]]
   endelse
  
endfor
print,n

return,csum

end
   
   
   
   
