;pick the largest cluster
idcluster,gb60,c01,deltar=4.3,list=s01 
a=max(s01(0,*))
w=where(s01(0,*) eq a)
da1=c01(*,w)
w=where(da1 gt 0)
gbc1=gb(*,w)
write_gdf,gbc1,'gbc1 60'
end