;circulation to calculate the I(r) integeral
;calculate the integration on the point r, the integration range from amin to amax, the range selection depends on the choice of gr 
function integrate,r,amax,amin,n,gr=gr,ti=ti
pi=3.14159265358
imin=amin*10
imax=amax*10
sum=0

for i=imin,imax do begin
   dr=i*0.1-r
   if (dr ge 0) then begin
   temp=(gr(1,i)-1-n*ti)*(gr(1,dr*10)-1)*4*pi*(i*0.1)*(i*0.1)*0.1
   endif else begin
   temp=(gr(1,i)-1-n*ti)*(gr(1,-dr*10)-1)*4*pi*(i*0.1)*(i*0.1)*0.1
   endelse
   sum=sum+temp
endfor

return,sum

end 