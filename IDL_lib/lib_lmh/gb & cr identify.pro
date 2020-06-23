pro gcidentify,data=data,number
cr=where(data(3,*) gt 7)
cr=data(*,cr)
gb1=where(data(14,*) gt 13 and data(3,*) le 9)
gb2=where(data(14,*) lt 13 and data(3,*) le 7)
gb=[[data(*,gb1)],[data(*,gb2)]]
write_gdf,gb,'gb'+number+'.gdf'
write_gdf,cr,'cr'+number+'.gdf'
write_gdf,data,'bond'+number+'.gdf'
end