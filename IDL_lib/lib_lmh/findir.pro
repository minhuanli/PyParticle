;find every i(r) for r
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

;--------------------------------------------------------------------------------------
function findir,r,amax,amin,n=n,gr=gr
result=fltarr(1,10000)
ti=-8000

;step=1000 part
i=0
result(0,i)=integrate(r,amax,amin,n,gr=gr,ti=ti)
repeat begin 
 delta0=ti-result(0,i)
 i=i+1
 ti=ti+1000
 result(0,i)=integrate(r,amax,amin,n,gr=gr,ti=ti)
 delta1=ti-result(0,i)
 judge=delta0*delta1
endrep until judge le 0

;step=100 part
ti=ti-1000
i=0
result(0,i)=integrate(r,amax,amin,n,gr=gr,ti=ti)
repeat begin 
 delta0=ti-result(0,i)
 i=i+1
 ti=ti+100
 result(0,i)=integrate(r,amax,amin,n,gr=gr,ti=ti)
 delta1=ti-result(0,i)
 judge=delta0*delta1
endrep until judge le 0

;step=10 part
ti=ti-100
i=0
result(0,i)=integrate(r,amax,amin,n,gr=gr,ti=ti)
repeat begin 
 delta0=ti-result(0,i)
 i=i+1
 ti=ti+10
 result(0,i)=integrate(r,amax,amin,n,gr=gr,ti=ti)
 delta1=ti-result(0,i)
 judge=delta0*delta1
endrep until judge le 0




;step=1 part
ti=ti-10
i=0
result(0,i)=integrate(r,amax,amin,n,gr=gr,ti=ti)
repeat begin 
 delta0=ti-result(0,i)
 i=i+1
 ti=ti+1
 result(0,i)=integrate(r,amax,amin,n,gr=gr,ti=ti)
 delta1=ti-result(0,i)
 judge=delta0*delta1
endrep until judge le 0

;step=0.1 part
ti=ti-1
i=0
result(0,i)=integrate(r,amax,amin,n,gr=gr,ti=ti)
repeat begin 
 delta0=ti-result(0,i)
 i=i+1
 ti=ti+0.1
 result(0,i)=integrate(r,amax,amin,n,gr=gr,ti=ti)
 delta1=ti-result(0,i)
 judge=delta0*delta1
endrep until judge le 0

;step=0.01 part
ti=ti-0.1
i=0
result(0,i)=integrate(r,amax,amin,n,gr=gr,ti=ti)
repeat begin 
 delta0=ti-result(0,i)
 i=i+1
 ti=ti+0.01
 result(0,i)=integrate(r,amax,amin,n,gr=gr,ti=ti)
 delta1=ti-result(0,i)
 judge=delta0*delta1
endrep until judge le 0

;step=0.001 part
ti=ti-0.01
i=0
result(0,i)=integrate(r,amax,amin,n,gr=gr,ti=ti)
repeat begin 
 delta0=ti-result(0,i)
 i=i+1
 ti=ti+0.001
 result(0,i)=integrate(r,amax,amin,n,gr=gr,ti=ti)
 delta1=ti-result(0,i)
 judge=delta0*delta1
endrep until judge le 0

ti=ti-0.001

return,ti

print,ti
print,result

end





