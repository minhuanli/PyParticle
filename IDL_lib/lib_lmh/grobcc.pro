;group the bcc's neighbours to two teams: 8 and 6
;group by the angle, the 6 group have 4 angle lie around pi/2
;output 0)6/8 1)x 2)y 3)z
function grobcc, pos=pos
n=n_elements(pos(0,*))
indice=fltarr(1,n)
poss=[indice,pos]
s=0
e=0
for i=0,n-1 do begin
   v=poss(1:3,i)
   temp=fltarr(1,n)
   for j=0,n-1 do begin
      temp(j)=cal_angle(v,poss(1:3,j))
   endfor
   w=where(temp gt 1.45 and temp lt 1.70,nc)
   if (nc eq 4) then begin
     poss(0,i)=6
     s=s+1 
   endif else begin
     poss(0,i)=8
     e=e+1
   endelse
endfor  
w=sort(poss(0,*))
poss=poss(*,w)

print,s
print,e
return,poss
end 
