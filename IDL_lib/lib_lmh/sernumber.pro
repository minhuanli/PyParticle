pro sernumber,data,f=f

n=n_elements(data(f,*))
 for i=0,n-1 do begin
  data(f,i)=i
 endfor

end