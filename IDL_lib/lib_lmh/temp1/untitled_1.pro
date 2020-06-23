print,'pos2'
file = file_search('D:\liminhuan\data-m2\mf-boo\recalc-boom2-cell-mf-p       2_time-*')
for i = 0,2 do begin
  boo = read_gdf(file(i))
  zmax = max(boo(2,*))
  zmin = min(boo(2,*))
  dz=(zmax+zmin)/3
  lower  = boo(*,where(boo(2,*) ge zmin and boo(2,*) le zmin+dz+5))
  middle = boo(*,where(boo(2,*) ge zmin+dz-5 and boo(2,*) le zmin+2*dz+5))
  upper  = boo(*,where(boo(2,*) ge zmin+2*dz-5 and boo(2,*) le zmax))
  blowc = edgecut(lower)
  bmidc = edgecut(middle)
  bupc = edgecut(upper)
  
  ; low solid slice 
  window,0,xsize=800,ysize=800
  test0 = polycut(blowc,f1=0,f2=2)
  w=where(test0(5,*) gt 0.35)
  plot,test0(0,w),test0(1,w),psym=8,backgr='ffffff'x,color='000000'x,/iso,symsize=0.75
  ;saveimage, 0, [800,800], 'D:\liminhuan\s-s transition project\mf p2 low\m2p2solidlow time'+string(i)+'.png', type=4
  
  ; low bcc slice
  ;window,0,xsize=800,ysize=800
  ;test0 = polycut(blowc,f1=0,f2=2)
  w=where(test0(5,*) gt 0.35 and test0(16,*) gt 13)
  ;plot,test0(0,w),test0(1,w),psym=8,backgr='ffffff'x,color='000000'x,/iso,symsize=0.75
  oplot,test0(0,w),test0(1,w),psym=8,color=1000,symsize=0.75
  saveimage, 0, [800,800], 'D:\liminhuan\s-s transition project\mf p2 low\m2p2spbcclow time'+string(i)+'.png', type=4
  
  
;  ; mid solid slice 
;  window,0,xsize=800,ysize=800
;  test1 = polycut(bmidc,f1=0,f2=2)
;  w=where(test1(5,*) gt 0.35)
;  plot,test1(0,w),test1(1,w),psym=8,backgr='ffffff'x,color='000000'x,/iso,symsize=0.75
;  saveimage, 0, [800,800], 'D:\liminhuan\data-m2\mf001-class\p2\p2solidmid time'+string(i)+'.png', type=4
;  
;  ; mid bcc slice
;  window,0,xsize=800,ysize=800
;  ;test0 = polycut(blowc,f1=0,f2=2)
;  w=where(test1(5,*) gt 0.35 and test1(16,*) gt 13)
;  plot,test1(0,w),test1(1,w),psym=8,backgr='ffffff'x,color='000000'x,/iso,symsize=0.75
;  saveimage, 0, [800,800], 'D:\liminhuan\data-m2\mf001-class\p2\p2bccmid time'+string(i)+'.png', type=4
;  
;  
;  ; high solid slice 
;  window,0,xsize=800,ysize=800
;  test2 = polycut(bupc,f1=0,f2=2)
;  w=where(test2(5,*) gt 0.35)
;  plot,test2(0,w),test2(1,w),psym=8,backgr='ffffff'x,color='000000'x,/iso,symsize=0.75
;  saveimage, 0, [800,800], 'D:\liminhuan\data-m2\mf001-class\p2\p2solidup time'+string(i)+'.png', type=4
;  
;  ; high bcc slice
;  window,0,xsize=800,ysize=800
;  ;test0 = polycut(blowc,f1=0,f2=2)
;  w=where(test2(5,*) gt 0.35 and test2(16,*) gt 13)
;  plot,test2(0,w),test2(1,w),psym=8,backgr='ffffff'x,color='000000'x,/iso,symsize=0.75
;  saveimage, 0, [800,800], 'D:\liminhuan\data-m2\mf001-class\p2\p2bccup time'+string(i)+'.png', type=4
  
  endfor

end
  
  
 
  