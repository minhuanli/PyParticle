function subset,a,b,setnumber=setnumber
 c=-1
 for i=0L,n_elements(a)-1 do begin
  w=where(a[i] eq b,n)
  if n eq 0 then c=[c,a[i]]  
 endfor
 d=shift(c,-1)
 if n_elements(d) eq 1 then begin
 setnumber=0
 return,d
 endif
 d=d[0:n_elements(d)-2]
 setnumber=n_elements(d)
 return,d
end