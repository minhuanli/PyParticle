;select the nearest paricles around a certain particle
;data contains all the particles position need to be judged, cp is the central particle 
;0)distance 1)x 2)y 3)z 
;the output data will be sorted by the distance off the central particle;
;if the data include the central particle itself, the output data will obviously include it and it should be the first one.
;nmax should be the number of nb plus 1(the cp itself)
;0)r^2 1)x 2)y 3)z
function selectnearest,odata, cp=cp,rmax=rmax, nmax=nmax
t=round(cp(15))
w=where(odata(15,*) eq t)
data=odata(*,w)
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

   
;======================================================================
;======================================================================
;======================================================================   

function haindexsta,cpdata,data,neir=neir,bondr=bondr,nb,count=count

 n=n_elements(cpdata(0,*))
 index=fltarr(12,n)
 s=0
for i=0L,(n-1) do begin
 dt=selectnearest(data,cp=cpdata(*,i),rmax=neir,nmax=nb+1)
 nn=n_elements(dt(0,*))
 if nn lt nb-4 then continue
 tindex=haindex(dt(1:3,*),deltar=bondr,bondmax=nb)
 nnn=n_elements(tindex(0,*))
 if s+nnn le n then index(*,s:(s+nnn-1))=tindex else index=[[index(*,0:s-1)],[tindex]]
 s=s+nnn
endfor
;------------------------------do count-----------------------
    count=fltarr(3,8)
    
    w1=where(index(0,*) eq 1421,nw1)
    count(0,0)=1421
    count(1,0)=nw1
    count(2,0)=float(nw1)/n
    
    w1=where(index(0,*) eq 1422,nw1)
    count(0,1)=1422
    count(1,1)=nw1
    count(2,1)=float(nw1)/n
    
    w1=where(index(0,*) eq 1431,nw1)
    count(0,2)=1431
    count(1,2)=nw1
    count(2,2)=float(nw1)/n
    
    w1=where(index(0,*) eq 1541,nw1)
    count(0,3)=1541
    count(1,3)=nw1
    count(2,3)=float(nw1)/n
    
    w1=where(index(0,*) eq 1551,nw1)
    count(0,4)=1551
    count(1,4)=nw1
    count(2,4)=float(nw1)/n
    
    w1=where(index(0,*) eq 1661,nw1)
    count(0,5)=1661
    count(1,5)=nw1
    count(2,5)=float(nw1)/n
    
    w1=where(index(0,*) eq 1441,nw1)
    count(0,6)=1441
    count(1,6)=nw1
    count(2,6)=float(nw1)/n
    
    w1=where(index(0,*) eq 2451,nw1)
    count(0,7)=2451
    count(1,7)=nw1
    count(2,7)=float(nw1)/n
 
;-------------------------------------------------------------------
return,index

end
  