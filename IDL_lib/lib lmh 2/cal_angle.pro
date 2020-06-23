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
cs=(x1*x2+y1*y2+z1*z2)/(r1*r2)
a=acos(cs)
endelse 
return,a

end