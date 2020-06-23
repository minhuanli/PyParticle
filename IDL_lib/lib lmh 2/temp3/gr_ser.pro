dir1 = 'D:\liminhuan\s-s transition project\0801 data\boo\mf1\'
dir2 = 'D:\liminhuan\s-s transition project\0801 data\boo\mf2\'
file = ['boom1-cell0801-mf1-p','0801mf2bondm1_p']

for i = 4,4 do begin 

data1 = file_search(dir1+file(0)+string(i)+'*')
data2 = file_search(dir2+file(1)+string(i)+'*')
filein = [data1,data2]
nb = n_elements(filein)
re = fltarr(5,nb) 

for t = 0, nb-1 do begin 
  time0 = systime(/second)
  boo = read_gdf(filein(t))
  bc = eclip(boo,[0,50,100],[1,50,100],[2,35,75])
  re(0,t) = t 
  re(1,t) = mean(bc(5,*))
  re(2,t) = stddev(bc(5,*))
  re(3,t) = mean(bc(8,*))
  re(4,t) = stddev(bc(8,*))
  w=where(bc(5,*) gt 0.30)
  gri = ericgr3d(bc(*,w),rmin=0.1,rmax=10.0,deltar=0.02) 
  ;va =voronoicell(bc,maxr=2.5)
  write_gdf,gri,'D:\liminhuan\s-s transition project\0801 data\gr\'+'gr_targetbox'+string(t)+'.gdf'
  print,systime(/seconds) - time0
endfor
write_text,re,'D:\liminhuan\s-s transition project\0801 data\w6q6_time.txt'
endfor

end 
  