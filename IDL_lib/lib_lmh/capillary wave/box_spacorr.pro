;designed for gbdy1026,2d distance,boxed . input data should be at a specific time
;output, 0: x dis 1: y dis 2 :total dis 3, correlation
;boxt is the average z of box(i,j) at specific time, 0,indice i; 1, indice j; 2, number; 3, average z; 4, fluctuate 5, time 
function box_spacorr,boxt=boxt,time=time,dx=dx,dy=dy
 w=where(boxt(2,*) gt 0 and boxt(5,*) eq time,nw)
 bb=boxt(*,w)
 res = fltarr(4,nw*nw)
 k=0.
 for i = 0,nw-1 do begin
  for j = 0,nw-1 do begin
    res(3,k) = bb(4,i)*bb(4,j)
    res(0,k)= abs(boxt(0,i)-boxt(0,j))*dx
    res(1,k)= abs(boxt(1,i)-boxt(1,j))*dy
    res(2,k)=sqrt(res(0,k)^2+res(1,k)^2)
    k = k +1
  endfor
 endfor
return,res
end