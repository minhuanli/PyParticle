cd,'F:\NEW\0-07'
epretrack,'artwork master.tif',bplo=2,bphi=7,dia=5,mass=2500,/multi,newname='step1c'
epretrack,'artwork master.tif',bplo=1,bphi=3,dia=3,mass=150,/multi,newname='step1v'
center=read_gdf('step1c*')
vertices=read_gdf('step1v*')
print,n_elements(center(5,*))/(max(center(5,*))+1)&print,max(center(5,*))+1
END