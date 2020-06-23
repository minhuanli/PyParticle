function voronoicg,booo,dr=dr
boo=booo
t1=max(boo(15,*))-min(boo(15,*))
ta=min(boo(15,*))+findgen(t1+1)
for j=0,t1 do begin
print,j
w=where(boo(15,*) eq ta[j],na)
pos=boo(*,w)
v01=fltarr(1,na)
for i=0.,na-1 do begin
dx=pos(0,*)-pos(0,i)
dy=pos(1,*)-pos(1,i)
dz=pos(2,*)-pos(2,i)
a1=(dx)^2+(dy)^2+(dz)^2
w1=where(a1 gt -1 and a1 le dr^2,wb)
v01(0,i)=mean(pos(12,w1))
endfor
boo(13,w)=v01
endfor
boo1=boo
return,boo1
end

