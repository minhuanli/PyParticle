;data1 0, time  1, local type  2, solid type
function matrixreform2, data1
nn = n_elements(data1(0,*))
res = fltarr(5,nn)
res(*,*) =  -1
for t = 0,nn-1 do begin
   res(0,t) = data1(0,t)
   if data1(1,t) eq 1 then res(1,t) = 1
   if data1(1,t) eq 2 then res(2,t) = 1
   if data1(1,t) eq 3 then res(3,t) = 1
   if data1(1,t) eq 4 then res(4,t) = 1
;   if data1(1,t) eq 5 then res(2,t) = 1
;   if data1(1,t) eq 6 then res(3,t) = 1
;   if data1(1,t) eq 8 then res(4,t) = 1
endfor

return,res

end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;time0 = eclip(ball,[5,0,0])
;timef = clu3
;cp0 = polycut(timef,f1=0,f2=2)
;cp0 = polycut(cp0,f1=0,f2=1)
cp0 = test2
npar = n_elements(cp0(0,*))

for i = 0, npar -1 do begin
   print, i
   w=where(bc(18,*) eq cp0(18,i))
   typeevoi = [bc(17,w),bc(19,w)]
   
   window,0,xsize=800,ysize=200
   w=where(typeevoi(1,*) eq 4, nw)
   if nw ne 0 then typeevoi(1,w) = 1
   w=where(typeevoi(1,*) eq 5, nw)
   if nw ne 0 then typeevoi(1,w) = 2
   w=where(typeevoi(1,*) eq 6, nw)
   if nw ne 0 then typeevoi(1,w) = 3
   w=where(typeevoi(1,*) ge 7, nw)
   if nw ne 0 then typeevoi(1,w) = 4
   
   plot,typeevoi(0,*),typeevoi(1,*),yrange=[0,5],psym=-8,background = 'ffffff'x,color= '000000'x
   ;oplot,typeevoi(0,*),typeevoi(2,*)-0.05,psym=-8,color= '0000ee'x
   saveimage,0,[800,200],'D:\liminhuan\pre2solid fluc\simudata\03tmlocaltype\np2'+string(i)+'.png',type=4
   write_text,matrixreform2(typeevoi),'D:\liminhuan\pre2solid fluc\simudata\03tmlocaltype\np2'+string(i)+'.txt'
   ;jump1: continue
 endfor
 
 end