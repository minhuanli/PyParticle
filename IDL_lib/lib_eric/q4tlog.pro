function q4tlog,trb,deltarl=deltarl,points=points
n1=max(trb(6,*))+1
dts=indgen(points)+1
qtx4=findgen(3,points)
qt1=findgen(points)
x4t=findgen(points)
a0=10^(alog10(0.9*(max(trb(5,*))+1))/points)
dts1=round(a0^dts)
dx3=findgen(n1)
for j=0,points-1 do begin
for i=0,n1-1 do begin
w1=where(trb(6,*) eq i)
trc=trb(*,w1)
dx=getdx(trc,dts1(j),dim=2)
w=where(dx(2,*) gt 0)
dx2=mean(dx(2,w))
dx3(i)=dx2^2
endfor
data=exp(-dx3/(2*deltarl^2))
result1=mean(data)
result2=mean(data^2)-mean(data)^2
qt1(j)=result1
print,j
x4t(j)=n1*result2
endfor
qtx4(0,*)=transpose(dts1)
qtx4(1,*)=transpose(qt1)
qtx4(2,*)=transpose(x4t)
return,qtx4
end