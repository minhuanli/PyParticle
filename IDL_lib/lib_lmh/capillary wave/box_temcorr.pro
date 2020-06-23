;boxt here should be cover all indices and all time series
;boxt,0,indice i; 1, indice j; 2, number; 3, average z; 4, fluctuate 5, time 
function box_temcorr,boxt=boxt,idi=idi,idj=idj
w=where(boxt(0,*) eq idi and boxt(1,*) eq idj and boxt(2,*) gt 0,nw)
bb = boxt(*,w)
res = fltarr(2,nw*nw)
k = 0.
 for i = 0., nw -1 do begin
   for j = 0, nw -1 do begin
     res(1,k) = bb(4,i)*bb(4,j)
     res(0,k) = abs(bb(5,i)-bb(5,j))
     k =k+1.
   endfor
 endfor
return,res
end