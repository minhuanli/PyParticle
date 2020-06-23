function booimage,boo,dim=dim,f1=f1
xmin=min(boo(0,*))
xmax=max(boo(0,*))
ymin=min(boo(1,*))
ymax=max(boo(1,*))
a03=fltarr(dim,dim)
xx=interpol([xmin,xmax],dim+1)
yy=interpol([ymin,ymax],dim+1)
for j=0,dim-1 do begin
w=where(boo(0,*) ge xx[j] and boo(0,*) lt xx[j+1],nb)
if nb gt 0 then begin
a01=avgbin(boo(1,w),boo(f1,w),binsize=(ymax-ymin)/dim)
a02=a01(1,0:dim-1)
a03(j,*)=a02
endif
endfor
return,a03
end

