boo = catptdata('D:\liminhuan\s-s transition project\0808 data\boo\after sub\0808-boo-after-sub-p*')
w = where(boo(5,*) gt 0.35)
gri = ericgr3d(boo(*,w),rmin=0.1,rmax=10.0,deltar=0.02) 
write_gdf,gri,'D:\liminhuan\s-s transition project\0808 data\grall\'+'gr_24h'+'.gdf'

end