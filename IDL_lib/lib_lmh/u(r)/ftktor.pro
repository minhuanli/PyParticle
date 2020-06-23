function ftktor,ck,rmin,rmax,deltar
n=(rmax-rmin)/deltar
b=complex(0,1)
pi=3.1415926
nn=n_elements(ck(0,*))
result=fltarr(2,n+1)
for i=0,n do begin
   result(0,i)=rmin+i*deltar
   temp=0.
   for j=0,nn-2 do begin
     dk=ck(0,j+1)-ck(0,j)
     temp=temp + Real_part(ck(1,j)*exp(-b*ck(0,j)*result(0,i))*dk/(sqrt(2*pi))) 
   endfor
  result(1,i)=temp
endfor

return,result

end