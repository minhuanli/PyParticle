;select the nearest paricles around a certain particle
;data contains all the particles position need to be judged, cp is the central particle 
;0)distance 1)x 2)y 3)z 
;the output data will be sorted by the distance off the central particle;
;if the data include the central particle itself, the output data will obviously include it and it should be the first one.
;nmax should be the number of nb plus 1(the cp itself)
;0)r^2 1)x 2)y 3)z
function selectnearest,odata, cp=cp,rmax=rmax, nmax=nmax
;t=round(cp(17))
;w=where(odata(17,*) eq t)


data=odata
xmin=cp(0)-rmax-1
ymin=cp(1)-rmax-1
zmin=cp(2)-rmax-1
xmax=cp(0)+rmax+1
ymax=cp(1)+rmax+1
zmax=cp(2)+rmax+1
w=where(data(0,*) ge xmin and data(0,*) le xmax and data(1,*) ge ymin and data(1,*) le ymax and data(2,*) ge zmin and data(2,*) le zmax , nw) 
tp=data(*,w)
x0=cp(0)
y0=cp(1)
z0=cp(2)
j=0
;--------------------------------------------------------------------------------------
;find the particles within range rmax
for i=0.,(nw-1) do begin
   x=tp(0,i)
   y=tp(1,i)
   z=tp(2,i)
   rx2=(x-x0)*(x-x0)
   ry2=(y-y0)*(y-y0)
   rz2=(z-z0)*(z-z0)
   r2=rx2+ry2+rz2
   judge=r2-rmax*rmax
   if (judge le 0) then begin
     temp=[r2,tp(*,i)]
     if (j eq 0) then begin
        nb=temp
     endif else begin
        nb=[[nb],[temp]]
     endelse
     j=j+1
   endif
endfor   
;----------------------------------------------------------------------------------------
;find the nearest nmax particles
if (j eq 0)  then begin 
   print, 'find no particle in the rmax range' 
endif else begin
   if (j le nmax) then begin
      
      s=sort(nb(0,*))
      l=n_elements(nb(*,0))
      nb1=fltarr(l,j)
      
      for i=0,(j-1) do begin
         nb1(*,i)=nb(*,s(i))
      endfor
      
      return,nb1
   
   endif else begin
      s=sort(nb(0,*))
      l=n_elements(nb(*,0))
      nb1=fltarr(l,nmax)
      
      for i=0,(nmax-1) do begin
         nb1(*,i)=nb(*,s(i))
      endfor
      
      return ,nb1
   endelse
endelse

end  

   
   
