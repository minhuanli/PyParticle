
;dir = 'D:\liminhuan\s-s transition project\1105 data\boo\boo_'
;file = ['bf_p3','p3_0min','p3_10min','p3_20min','p3_30min','p3_40min','p3_45min','p3_70min']

dir1 = 'D:\liminhuan\s-s transition project\0809 data\boo\0809-boo-mf1\'
dir2 = 'D:\liminhuan\s-s transition project\0809 data\boo\0809-boo-mf2\'
file = ['0809-boo-mf1-p','0809-boo-mf2-p']
for i = 1,5 do begin
data1 = file_search(dir1+file(0)+string(i)+'*')
data2 = file_search(dir2+file(1)+string(i)+'*')
filein = [data1,data2]

nb = n_elements(filein)
  
  for t = 0,nb-1 do begin 
  
  newdir = 'D:\liminhuan\s-s transition project\0809 data\real_space\pos'+string(i)+'\'
  ;file_mkdir,newdir 
  
   for s = 0 ,15 do begin 
     newdir = 'D:\liminhuan\s-s transition project\0809 data\real_space\pos'+string(i)+'\xz_s'+string(s)+'\'
     if t eq 0 then begin
     file_mkdir,newdir
     endif    
     
     bc = edgecut(read_gdf(filein(t)))  
     test0 = eclip(bc,[1,5+s*6.5,10+s*6.5]) 
     window,0,xsize=800,ysize=800
     w=where(test0(5,*) gt 0.33 and test0(8,*) lt -0.007)
     plot,test0(0,w),test0(2,w),psym=8,backgr='ffffff'x,color='000000'x,symsize=0.7 
     
     w=where(test0(5,*) lt 0.30,nw)
     if nw gt 0 then oplot,test0(0,w),test0(2,w),psym=8,color='FF0000'x,symsize=0.7  ; blue
  
     w=where(test0(5,*) gt 0.35 and test0(8,*) gt 0,nw)
     if nw gt 0 then oplot,test0(0,w),test0(2,w),psym=8,color='0000EE'x,symsize=0.7   ; red
  
     w=where(test0(5,*) gt 0.35 and test0(8,*) gt -0.007 and test0(8,*) lt 0,nw)   ;precursor1
     if nw gt 0 then oplot,test0(0,w),test0(2,w),psym=8,color='32CD32'x,symsize=0.7   ; grenn
     saveimage, 0, [800,800],newdir+'time'+string(t)+'.png', type=4
   endfor
  endfor

endfor 

end  
     