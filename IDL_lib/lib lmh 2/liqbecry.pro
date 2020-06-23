pro liqbecry, liq,data,dr
 
 n1=n_elements(liq(0,*))
 for i=0,n1-1 do begin 
     xmin=liq(0,i)-dr
     xmax=liq(0,i)+dr
     ymin=liq(1,i)-dr
     ymax=liq(1,i)+dr
     zmin=liq(2,i)-dr
     zmax=liq(2,i)+dr
     w=where(data(0,*) ge xmin and data(0,*) le xmax and data(1,*) ge ymin and data(1,*) le ymax and data(2,*) ge zmin and data(2,*) le zmax,nw)
     nb=data(*,w)
     s=0
   for j=0,nw-1 do begin
     ju=nb(3,j)
     if (ju ge 7) then s=s+1
   endfor
     if s gt 0 then liq(15,i)=1 else liq(15,i)=0
  endfor 
end   
  
      