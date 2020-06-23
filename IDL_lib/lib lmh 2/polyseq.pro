;---------------------------------------------------------------------------------------------
;sort the random point (which should all be in one surface) to clockwise or anti-clockwise, the angle and cross product
;may occur some mistake for highly symmetrical structure like square
function polyseq,trb
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
   ;seq=trb(*,w)
   
   return,w
end