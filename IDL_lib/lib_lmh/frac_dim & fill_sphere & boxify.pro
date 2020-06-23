;fill the sphere center with surrounding densely distributed dots, simulating a real ball in 3d space. 
; for a further calculation about fractal dimension
; how to distribute points homogeneously in a ball. see https://www.cnblogs.com/TenosDoIt/p/4025221.html
; http://mathworld.wolfram.com/SpherePointPicking.html, the discussion about smapleing in theta is inspiring
; created by lmh @ TP's lab 2018.11.21 
function fill_sphere, data, r=r, num=num
n = n_elements(data(0,*))
temp = data
for i = 0, n-1  do begin 
   rfill = randomu(undefinevar,num)^(1./3.)*r
   thetafill = acos( 2.*randomu(undefinevar,num)-1. )
   phifill = randomu(undefinevar,num)*2*!pi
   x = data(0,i) + rfill * sin(thetafill)* cos(phifill)
   y = data(1,i) + rfill * sin(thetafill)* sin(phifill)
   z = data(2,i) + rfill * cos(thetafill)
   temp = [[temp],[transpose(x),transpose(y),transpose(z)]]
endfor
return,temp
end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
function rd_shift, data, r=r
n = n_elements(data(0,*))
temp = data
for i = 0, n-1  do begin 
   rfill = randomu(undefinevar,1)^(1./3.)*r
   thetafill = acos( 2.*randomu(undefinevar,1)-1. )
   phifill = randomu(undefinevar,1)*2*!pi
   temp(0,i) = data(0,i) + rfill * sin(thetafill)* cos(phifill)
   temp(1,i) = data(1,i) + rfill * sin(thetafill)* sin(phifill)
   temp(2,i) = data(2,i) + rfill * cos(thetafill)
   ;temp = [[temp],[transpose(x),transpose(y),transpose(z)]]
endfor
return,temp
end
;-----------------------------------------
; boxify the cluster and surrounding margin
function boxify, data, boxs=boxs,shape = shape,margin=margin
if not(keyword_set(margin)) then margin = 5.
x1 = min(data(0,*)) - margin
x2 = max(data(0,*)) + margin
y1 = min(data(1,*)) - margin
y2 = max(data(1,*)) + margin
z1 = min(data(2,*)) - margin
z2 = max(data(2,*)) + margin
nx = ceil( (x2-x1) / boxs )
ny = ceil( (y2-y1) / boxs )
nz = ceil( (z2-z1) / boxs )
res = bytarr(nx,ny,nz)
shape = [nx,ny,nz]
for i = 0, nx -1 do begin 
   for j = 0, ny-1 do begin 
      for k = 0 , nz-1 do begin 
         w=where(data(0,*) gt x1+i*boxs and data(0,*) lt x1+(i+1)*boxs and data(1,*) gt y1+j*boxs and data(1,*) lt y1+(j+1)*boxs $
         and data(2,*) gt (z1+k*boxs) and data(2,*) lt (z1+(k+1)*boxs),nw)
         if nw eq 0 then continue else res(i,j,k) = 1
       endfor
   endfor
endfor
return,res
end

; first select the target cluster; then fill all the sparse point with sphere with densely discrete points
; then box the whole 
function frac_dim_1, odata, r=r, fill=fill, boxss = boxss
 data = odata(0:2,*)
 if keyword_set(fill) then data = fill_sphere(data,r=r,num=800)
 nn = n_elements(boxss)
 res = fltarr(3,nn)
 for bb = 0, nn-1 do begin
   start = systime(/seconds)
   print,boxss(bb)
   boxbb = boxify(data,boxs = boxss(bb),shape=shape, margin = 2.*boxss(bb))
   w=where(boxbb ne 0,nw) ; if your want to know the buld dimension, you can drop the following loop
   k = 0.
   for cc = 0, nw-1 do begin   ; do this loop to find out the boundary box
     zid = w(cc) / ( shape(0)*shape(1) )
     yid = (w(cc) - zid*shape(0)*shape(1)) / shape(0)
     xid = w(cc) - zid*shape(0)*shape(1) - shape(0)*yid
     ww=where(boxbb(xid-1:xid+1,yid-1:yid+1,zid-1:zid+1) eq 0, nww)
     if nww ge 4 then k = k+1 
   endfor
  res(0,bb) = boxss(bb)
  res(1,bb) = k
  res(2,bb) = nw
  print,'now finish'+string(boxss(bb)) + ': '+ string( systime(/seconds) - start) 
 endfor

;print,fit_dim(res,f1=1,f2=0)
;print,fit_dim(res,f1=2,f2=0)
;plot,alog(res(1,*)),alog(res(0,*)),psym=-1
return,res

end 
 
function fit_dim,data,f1=f1,f2=f2,sigma=sigma
  res = linfit(alog(data(f1,*)),alog(data(f2,*)),sigma=sigma)
return,res
end