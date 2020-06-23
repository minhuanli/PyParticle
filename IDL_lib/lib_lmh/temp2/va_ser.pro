dir1 = 'D:\liminhuan\s-s transition project\0808 data\boo\mf1\'
dir2 = 'D:\liminhuan\s-s transition project\0808 data\boo\mf2\'
name1 = '0809-boo-mf1-p       1-t'
name2 = '0809-boo-mf2-p       1-t'

file = file_search(dir2+name2+'*',count=nb) 

for t = nb-1, 0,-1 do begin 
  time0 = systime(/second)
  boo = read_gdf(file(t))
  bc = eclip(boo,[1,5,55],[2,55,105])
  ;w=where(boo(5,*) gt 0.35)
  ;gri = ericgr3d(boo(*,w),rmin=0.1,rmax=10.0,deltar=0.02) 
  va =voronoicell(bc,maxr=2.5)
  write_gdf,[bc,va],'D:\liminhuan\s-s transition project\0809 data\vavolume\'+'va_'+name2+string(t)+'.gdf'
  print,systime(/seconds) - time0
endfor

end