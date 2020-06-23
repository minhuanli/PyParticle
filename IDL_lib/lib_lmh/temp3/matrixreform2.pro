;data1 0, time  1, local type  2, solid type
function matrixreform2, data1
nn = n_elements(data1(0,*))
res = fltarr(8,nn)
res(*,*) =  -1
for t = 0,nn-1 do begin
   res(0,t) = data1(0,t)
   if data1(1,t) eq 1 then res(1,t) = 1
   if data1(1,t) eq 2 then res(2,t) = 1
   if data1(1,t) eq 3 then res(3,t) = 1
   if data1(1,t) eq 4 then res(4,t) = 1
   if data1(1,t) eq 5 then res(5,t) = 1
   if data1(1,t) eq 6 then res(6,t) = 1
   if data1(1,t) eq 8 then res(7,t) = 1
endfor

return,res

end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;time0 = eclip(ball,[5,0,0])
timef = clu2
cp0 = polycut(timef,f1=0,f2=2)
cp0 = polycut(cp0,f1=0,f2=1)
npar = n_elements(cp0(0,*))

for i = 0, npar -1 do begin
   print, i
   typeevoi = fltarr(2,500)
   typeevoi(0,499) = 499
   typeevoi(1,499) = cp0(17,i)
   for t = 499,1,-1 do begin
     if t mod 10 eq 0 then print, t
     if t eq 499 then cpt = cp0(0:2,i) else cpt = nbt(1:3,0)
     test = eclip(test2,[15,t-1,t-1])
     nbt = selectnearest(test,cp=cpt,rmax=3.5,nmax=5)
     if nbt(0,0) eq 0 then goto,jump1
     typeevoi(0,t-1) = t-1
     typeevoi(1,t-1) = nbt(17,0)
     ;typeevoi(2,t+1) = nbt(5,0)
   endfor
   window,0,xsize=800,ysize=200
   plot,typeevoi(0,*),typeevoi(1,*),psym=-8,background = 'ffffff'x,color= '000000'x
   ;oplot,typeevoi(0,*),typeevoi(2,*)-0.05,psym=-8,color= '0000ee'x
   saveimage,0,[800,200],'D:\liminhuan\pre2solid fluc\clu2fromtrb2\np'+string(i)+'.png',type=4
   write_text,matrixreform2(typeevoi),'D:\liminhuan\pre2solid fluc\clu2fromtrb2\np'+string(i)+'.txt'
   jump1: continue
 endfor
 
 end