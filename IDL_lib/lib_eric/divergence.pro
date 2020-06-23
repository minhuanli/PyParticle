function divergence,pos,value,dimension=dimension
g01=griddata(pos(0,*),pos(1,*),value,dimension=dimension)
x001=[min(pos(0,*)),max(pos(0,*))]
y001=[min(pos(1,*)),max(pos(1,*))]
x01=interpol(x001,dimension)
y01=interpol(y001,dimension)
data=fltarr(dimension,dimension)
data1=fltarr(dimension,dimension)
for j=0,dimension-1 do begin
dx=deriv(x01,g01(*,j))
dy=deriv(y01,g01(j,*))
data(*,j)=dx
data(j,*)=dy
endfor
data2=data+data1
return,data2
end