print,'pos2'
file0 = file_search('D:\liminhuan\s-s transition project\0808 data\boo\mf1\0809-boo-mf1-p       2-t*')
file1 = file_search('D:\liminhuan\s-s transition project\0808 data\boo\mf2\0809-boo-mf2-p       2-t*')
file = [file0,file1]
outfile = fltarr(14,40)
for i = 0,39 do begin
  
  boo = read_gdf(file(i))
  boo = edgecut(boo)
  
  zmax = max(boo(2,*))
  zmin = min(boo(2,*))
  dz=(zmax-zmin)/4
  b1  = boo(*,where(boo(2,*) ge zmin and boo(2,*) le zmin+dz))
  b2 = boo(*,where(boo(2,*) ge zmin+dz and boo(2,*) le zmin+2*dz))
  b3  = boo(*,where(boo(2,*) ge zmin+2*dz and boo(2,*) le zmin+3*dz))
  b4 = boo(*,where(boo(2,*) ge zmin+3*dz and boo(2,*) le zmin+4*dz))
 
   window,0,xsize=800,ysize=800
   test0 = eclip(boo,[2,40,50])
  plot,test0(0,*),test0(1,*),psym=8,backgr='ffffff'x,color='000000'x,/iso,symsize=0.75
  ;saveimage, 0, [800,800], 'D:\liminhuan\s-s transition project\mf001 p2 low\m1p2solidlow time'+string(i)+'.png', type=4
 
  ;window,0,xsize=800,ysize=800
  ;test0 = polycut(blowc,f1=0,f2=2)
  w=where(test0(5,*) lt 0.35)
  ;plot,test0(0,w),test0(1,w),psym=8,backgr='ffffff'x,color='000000'x,/iso,symsize=0.75
  oplot,test0(0,w),test0(1,w),psym=8,color='FF0000'x,symsize=0.75  ; blue
  
  w=where(test0(5,*) gt 0.35 and test0(8,*) gt 0)
  oplot,test0(0,w),test0(1,w),psym=8,color='0000EE'x,symsize=0.75   ; red
  
  w=where(test0(5,*) gt 0.35 and test0(8,*) gt -0.01 and test0(8,*) lt 0)   ;precursor1
  oplot,test0(0,w),test0(1,w),psym=8,color='32CD32'x,symsize=0.75   ; grenn
  
;  w=where(test0(5,*) gt 0.35 and test0(8,*) gt 0 and test0(8,*) lt 0.005)      ;precursor2
;  oplot,test0(0,w),test0(1,w),psym=8,color='8B1A1A'x,symsize=0.75   ; dark blue
  
  zz1 = min(test0(2,*))
  zz2 = max(test0(2,*))
  
  saveimage, 0, [800,800], 'D:\liminhuan\s-s transition project\0808 data\fig\realspace\pos2\xy4\slice'+'time'+string(i)+'zrange_'+string(zz1)+'to'+string(zz2)+'.png', type=4
  
  

  endfor

end
  