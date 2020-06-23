dir1 = 'D:\liminhuan\s-s transition project\0809 data\boo\0809-boo-mf1\0809-boo-mf1-p'
dir2 = 'D:\liminhuan\s-s transition project\0809 data\boo\0809-boo-mf2\0809-boo-mf2-p'


for i = 1 ,5 do begin 
   file1 = file_search(dir1 + string(i)+'*')
   file2 = file_search(dir2 + string(i)+'*')
   file = [file1,file2]
   for t = 0, 39 do begin 
   print, 'now ' + 'pos : ' + string(i) + 'time: ' + string(t)
     boo = edgecut(read_gdf(file(t)),dc=5.0)
     w = where(boo(5,*) gt 0.35 and boo(8,*) gt 0, nw) ; pick out bcc solid
     if nw lt 8 then continue 
     
     idcluster2,boo(*,w),c01,list=s01,deltar=2.5 ; do cluster analysis
     ww = where(s01(0,*) ge 5 and s01(0,*) le 2000, nww) 
     if nww eq 0 then continue 
     
     res = fltarr(4,nww)
     
      for j = 0,nww-1 do begin 
        clui = selecluster2(boo(*,w),c01=c01,nb=ww(j))
        res(0,j)= s01(0,ww(j))  ; cluster size
        res(1,j)= s01(4,ww(j))  ; gyration radius
        res(2,j)= mean(clui(8,*)) ; mean W6
        res(3,j)= mean(clui(5,*)) ; mean Q6
      endfor
      
     write_gdf,res,'D:\liminhuan\s-s transition project\paper figure\figure1\cluster_analysis_bcc\bccclu_pos'+string(i)+' t_'+ string(t)+'.gdf'  
     ;write_gdf,fdres,'D:\liminhuan\s-s transition project\paper figure\figure1\fracdim_liq_2\fdresliq_pos_'+string(i)+' t_'+ string(t)+'.gdf'
    
 endfor


endfor 

end
