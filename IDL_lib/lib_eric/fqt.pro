function fqt,trb,qx=qx,qy=qy,points=points
qt=(indgen(points)+1)
mqt=max(qt)
a0=10^(alog10(0.8*(max(trb(5,*))+1))/points)
qt1=round(a0^qt)
fqt1=findgen(2,points)
for j=0,mqt-1 do begin
dx=getdx(trb,qt1[j],dim=dims)
w=where(dx(2,*) gt 0)
fqt1(1,j)=mean(cos(qx*dx(0,w)+qy*dx(1,w)))
endfor
fqt1(0,*)=transpose(qt1)
return,fqt1
end