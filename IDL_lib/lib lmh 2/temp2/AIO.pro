cd,'F:\NEW\0-07'
;epretrack,'artwork master.tif',bplo=2,bphi=7,dia=5,mass=2500,/multi,newname='step1c'
;epretrack,'artwork master.tif',bplo=1,bphi=3,dia=3,mass=150,/multi,newname='step1v'
center=read_gdf('step1c*')
vertices=read_gdf('step1v*')
print,n_elements(center(5,*))/(max(center(5,*))+1)&print,max(center(5,*))+1
frame_align,center,vertices,center2,vertices2,reference,operation,101,21,432,482
write_text, center2, 'centers.txt '& write_text, vertices2, 'vertices.txt '&
voronoi_for_all,center2,ax,ay,553,/frame
find_boundary,bp,nonbp,particle,12,/hexagon
center_and_vertices,center2,vertices2,out,441,judge=judge,frame=frame
end