FUNCTION calbcc_xy,pos10=pos10,pos20=pos20

pi=3.14159
pos1=grobcc(pos=pos10)
pos2=grobcc(pos=pos20)
w1=reverse(sort(pos1(3,6:13)))
a11=pos1(1:3,6+w1(0))
a12=pos1(1:3,6+w1(1))
a13=pos1(1:3,6+w1(6))
a14=pos1(1:3,6+w1(7))
w2=reverse(sort(pos2(3,6:13)))
a21=pos2(1:3,6+w2(0))
a22=pos2(1:3,6+w2(1))
a23=pos2(1:3,6+w2(6))
a24=pos2(1:3,6+w2(7))
a1=a12-a11
a2=a22-a21
a3=a14-a13
a4=a24-a23
angle1=cal_angle(a1,a2)
angle2=cal_angle(a3,a4)
if (angle1 eq 0L and angle2 eq 0L) then begin
  angle=0L
endif else begin

if(angle1 gt (pi/2)) then angle1=pi-angle1 else angle1=angle1
if(angle2 gt (pi/2)) then angle2=pi-angle2 else angle2=angle2
angle=(angle1+angle2)/2
angle=angle1*180/pi

endelse

return,angle
end
