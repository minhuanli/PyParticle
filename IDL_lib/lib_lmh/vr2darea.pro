;determine the angle between two vectors
function cal_angle2d,v1,v2
if norm(v1-v2) le 0.00001 then begin
a=0L 
endif else begin
x1=v1(0,*)
y1=v1(1,*)
x2=v2(0,*)
y2=v2(1,*)
r1=sqrt(x1*x1+y1*y1)
r2=sqrt(x2*x2+y2*y2)
cs=(x1*x2+y1*y2)/((r1*r2)+0.0000001)
a=acos(cs)
endelse 
return,a

end


;---------------------------------------------------------------------------------------------
;first sort the random point (which should all be in one surface) to clockwise or anti-clockwise, the angle and cross product
;may occur some mistake for highlu symmetrical structure like squre
function polyarea2d,trb,seq=seq
   n=n_elements(trb(0,*))
   x0=mean(trb(0,*))
   y0=mean(trb(1,*))
   ;z0=mean(trb(2,*))
   vec=fltarr(2,n)
   vec(0,*)=trb(0,*)-x0
   vec(1,*)=trb(1,*)-y0
   ;vec(2,*)=trb(2,*)-z0
   angle=fltarr(1,n)
   angle(0)=0.000
   flag=0  
     for i=1,n-1 do begin
      cita=cal_angle2d(vec(0:1,0),vec(0:1,i))
       if (cita gt 3.13 or cita lt 0.01) then continue ;prevent csp=0
      csp0=crossp([vec(0:1,0),0],[vec(0:1,i),0])
      flag=1  
     endfor

;sort the random point (which should all be in one surface) to clockwise or anti-clockwise      
     for i=1,n-1 do begin
       if flag eq 0 then break
       tangle=cal_angle2d(vec(0:1,0),vec(0:1,i))
       tempcsp=crossp([vec(0:1,0),0.],[vec(0:1,i),0.])
       judge1=total(csp0*tempcsp)
       if judge1 le 0.00001 then angle(i)=2*!pi-tangle else angle(i)=tangle 
     end
   w=sort(angle(*))
   seq=trb(*,w)
   vecs=vec(*,w)
   vecs=[[vecs],[vec(0:1,0)]] 
   sum=0.
     for i=0,n-1 do begin
       if flag eq 0 then break
       aa=vecs(0:1,i)
       bb=vecs(0:1,i+1)
       cc=crossp([aa,0.],[bb,0.])
       temp=norm(cc)/2
       sum=sum+temp
     endfor
   
   return,sum
 
end
;----------------------------------------------------------------------------
;----------------------------------------------------------------------------
;--------------------------------------------------------------------
function vr2darea,trb,nb1=nb1

n1=n_elements(trb(0,*))
  pos=trb(0:1,*)
  area1=fltarr(1,n1)
  nb1=lonarr(1,n1)

qhull,pos,tr1,connectivity=con1,vvertices=v1,/delaunay

 for i=0.,(n1-1) do begin
    nbindice=con1[con1[i]:(con1[i+1]-1)]
    nb=n_elements(nbindice)
    nb1(0,i)=nb
        w=where(tr1(0,*) eq i or tr1(1,*) eq i or tr1(2,*) eq i)
        vv1=v1(*,w)
        area1(i)=polyarea2d(vv1(0:1,*))
 endfor
     
 return,area1
        
end
        

