;data1 0, time 1,neighbor mean Q6  1, local type  2, solid type
function matrixreform3, data1
nn = n_elements(data1(0,*))
res = fltarr(9,nn)
res(*,*) =  -1
for t = 0,nn-1 do begin
   res(0,t) = data1(0,t)
   ;res(1,t) = data1(2,t)
   res(1,t) = 0.
   if data1(1,t) eq 1 then res(2,t) = 1
   if data1(1,t) eq 2 then res(3,t) = 1
   if data1(1,t) eq 3 then res(4,t) = 1
   if data1(1,t) eq 4 then res(5,t) = 1
   if data1(1,t) eq 5 then res(6,t) = 1
   if data1(1,t) eq 6 then res(7,t) = 1
   if data1(1,t) ge 7 then res(8,t) = 1
endfor

return,res

end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;time0 = eclip(ball,[5,0,0])
timef = clu1
cp0 = polycut(timef,f1=0,f2=2)
cp0 = polycut(cp0,f1=0,f2=1)
npar = n_elements(cp0(0,*))

for i = 0, npar -1 do begin
   print, i
   w=where(boo1t(16,*) eq cp0(16,i),nw)
   typeevoi=fltarr(3,nw)
   cpser = boo1t(*,w)
   typeevoi(0,*) = cpser(15,*)
   typeevoi(1,*) = cpser(17,*)     
   dcc=6.0
   ;calculate mean neighbor cluster q6
   for j = 0, nw -1 do begin
   nbij = eclip(boo1t,[15,cpser(15,j),cpser(15,j)],[0,cpser(0,j)-dcc,cpser(0,j)+dcc],[1,cpser(1,j)-dcc,cpser(1,j)+dcc],[2,cpser(2,j)-dcc,cpser(2,j)+dcc])
   typeevoi(2,j) = mean(nbij(5,*)) ; cluster mean q6
   endfor
   window,0,xsize=800,ysize=200
   plot,typeevoi(0,*),typeevoi(1,*),yrange=[0,9],psym=-8,background = 'ffffff'x,color= '000000'x
   ;oplot,typeevoi(0,*),typeevoi(2,*)-0.05,psym=-8,color= '0000ee'x
   saveimage,0,[800,200],'D:\liminhuan\pre2solid fluc\booseries009data\clu1_q6\np'+string(i)+'.png',type=4
   write_text,matrixreform3(typeevoi),'D:\liminhuan\pre2solid fluc\booseries009data\clu1_q6\np'+string(i)+'.txt'
   jump1: continue
 endfor
 
 end