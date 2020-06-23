dir = 'D:\liminhuan\s-s transition project\0808 data\boo\after sub\'
name = '0808-boo-after-sub-p'

file = file_search(dir+name+'*',count=nb) 

for t = 0, nb-1  do begin 
  time0 = systime(/second)
  boo = read_gdf(file(t))
  w=where(boo(5,*) gt 0.35)
  gri = ericgr3d(boo(*,w),rmin=0.1,rmax=10.0,deltar=0.02) 
  write_gdf,gri,'D:\liminhuan\s-s transition project\0808 data\boo\after sub\'+'gr_'+name+string(t)+'.gdf'
  print,systime(/seconds) - time0
endfor

end 