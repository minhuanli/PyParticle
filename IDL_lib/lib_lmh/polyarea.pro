;determine the angle between two vectors
function cal_angle,v1,v2
if norm(v1-v2) le 0.00001 then begin
a=0L 
endif else begin
x1=v1(0,*)
y1=v1(1,*)
z1=v1(2,*)
x2=v2(0,*)
y2=v2(1,*)
z2=v2(2,*)
r1=sqrt(x1*x1+y1*y1+z1*z1)
r2=sqrt(x2*x2+y2*y2+z2*z2)
cs=(x1*x2+y1*y2+z1*z2)/((r1*r2)+0.0000001)
a=acos(cs)
endelse 
return,a

end


;---------------------------------------------------------------------------------------------
;first sort the random point (which should all be in one surface) to clockwise or anti-clockwise, the angle and cross product
;may occur some mistake for highly symmetrical structure like square
function polyarea,trb,seq=seq
   n=n_elements(trb(0,*))
   x0=mean(trb(0,*))
   y0=mean(trb(1,*))
   z0=mean(trb(2,*))
   vec=fltarr(3,n)
   vec(0,*)=trb(0,*)-x0
   vec(1,*)=trb(1,*)-y0
   vec(2,*)=trb(2,*)-z0
   angle=fltarr(1,n)
   angle(0)=0.000
   flag=0  
     for i=1,n-1 do begin
      cita=cal_angle(vec(0:2,0),vec(0:2,i))
       if (cita gt 3.13 or cita lt 0.01) then continue ;prevent csp=0
      csp0=crossp(vec(0:2,0),vec(0:2,i))
      flag=1  
     endfor

;sort the random point (which should all be in one surface) to clockwise or anti-clockwise      
     for i=1,n-1 do begin
       if flag eq 0 then break
       tangle=cal_angle(vec(0:2,0),vec(0:2,i))
       tempcsp=crossp(vec(0:2,0),vec(0:2,i))
       judge1=total(csp0*tempcsp)
       if judge1 le 0.00001 then angle(i)=2*!pi-tangle else angle(i)=tangle 
     end
   w=sort(angle(*))
   seq=trb(*,w)
   vecs=vec(*,w)
   vecs=[[vecs],[vec(0:2,0)]] 
   sum=0
     for i=0,n-1 do begin
       if flag eq 0 then break
       aa=vecs(0:2,i)
       bb=vecs(0:2,i+1)
       cc=crossp(aa,bb)
       temp=norm(cc)/2
       sum=sum+temp
     endfor
   
   return,sum
 
end