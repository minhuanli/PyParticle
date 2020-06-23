
dir1 = 'D:\liminhuan\s-s transition project\0809 data\boo\0809-boo-mf1\0809-boo-mf1-p'
dir2 = 'D:\liminhuan\s-s transition project\0809 data\boo\0809-boo-mf2\0809-boo-mf2-p'


for i = 1 ,5 do begin 
   file1 = file_search(dir1 + string(i)+'*')
   file2 = file_search(dir2 + string(i)+'*')
   file = [file1,file2]
   for t = 0, 39 do begin 
   print, 'now ' + 'pos : ' + string(i) + 'time: ' + string(t)
     boo = edgecut(read_gdf(file(t)),dc=5.0)
     w = where(boo(5,*) lt 0.34, nw) ; pick out liquid solid
     if nw lt 8 then continue 
     
     idcluster2,boo(*,w),c01,list=s01,deltar=2.5 ; do cluster analysis
     ww = where(s01(0,*) ge 8 and s01(0,*) le 100, nww) 
     if nww eq 0 then continue 
     
     res = fltarr(8,nww)
     fdres = fltarr(3,15*nww)
     
      for j = 0,nww-1 do begin 
        clui = selecluster2(boo(*,w),c01=c01,nb=ww(j))
        fd= frac_dim_1(clui,r=1.4,fill=1,boxss=[2.0,1.8,1.6,1.4,1.2,1.0,0.9,0.8,0.7,0.65,0.6,0.55,0.5,0.45,0.4])
        fdres(*, 15*j : (15*(j+1)-1) ) = fd
        res(0,j)= s01(0,ww(j))  ; cluster size
        res(1,j)= s01(4,ww(j))  ; gyration radius
        res(6,j)= mean(clui(8,*)) ; mean W6
        res(7,j)= mean(clui(5,*)) ; mean Q6
        fit1 = fit_dim(fd,f1=1,f2=0,sigma=sig1)
        fit2 = fit_dim(fd,f1=2,f2=0,sigma=sig2)
        res(2,j) = fit1(1) ; -1./ surface_dim 
        res(3,j) = sig1(1) ; sigma
        res(4,j) = fit2(1) ; -1./ bulk_dim
        res(5,j) = sig2(1) ; sigma
      endfor
      
     write_gdf,res,'D:\liminhuan\s-s transition project\paper figure\figure1\fracdim_liq_2\liq_pos_'+string(i)+' t_'+ string(t)+'.gdf'  
     write_gdf,fdres,'D:\liminhuan\s-s transition project\paper figure\figure1\fracdim_liq_2\fdresliq_pos_'+string(i)+' t_'+ string(t)+'.gdf'
    
 endfor


endfor 

end
