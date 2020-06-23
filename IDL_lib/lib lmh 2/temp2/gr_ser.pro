dir1 = 'D:\liminhuan\s-s transition project\0801 data\boo\mf1\'
dir2 = 'D:\liminhuan\s-s transition project\0801 data\boo\mf2\'
name2 = '0801mf2bondm1_p       4_time-'
name1 = 'boom1-cell0801-mf1-p       4'

file = file_search(dir1+name1+'*',count=nb) 

for t = 1, nb-1, 2 do begin 
  time0 = systime(/second)
  boo = read_gdf(file(t))
  w=where(boo(5,*) gt 0.35)
  gri = ericgr3d(boo(*,w),rmin=0.1,rmax=10.0,deltar=0.02) 
  write_gdf,gri,'D:\liminhuan\s-s transition project\0801 data\gr\'+'gr_'+name1+string(t)+'.gdf'
  print,systime(/seconds) - time0
endfor

end 
  