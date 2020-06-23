pro booanimate,data,a01,a02,za=za,z1=z1,z2=z2,dim=dim,write=write
;f1=findfile('F://crystalptdata//boo3davgt_20120308*')
;a1=read_gdf(f1[3])
a2=eclip(data,[za,z1,z2])
tmax=max(data(15,*),min=tmin)
ta=tmin+indgen(tmax-tmin+1)
taa=byte(tmin)+indgen(tmax-tmin+1)
tb=string(taa)
f01='a01'+tb+'.tif'
f02='a02'+tb+'.tif'
;f03='a03'+tb+'.tif'
;f04='a04'+tb+'.tif'
a01=fltarr(dim,dim,tmax-tmin+1)
a02=fltarr(dim,dim,tmax-tmin+1)
;a03=fltarr(dim,dim,tmax-tmin+1)
;a04=fltarr(dim,dim,tmax-tmin+1)
g04=bytarr(3*dim,3*dim)
for j=0,tmax-tmin do begin
print,j
w=where(a2(15,*) eq ta[j])
g01=griddata(a2(0,w),a2(2,w),a2(3,w),dimension=dim)
g02=griddata(a2(0,w),a2(2,w),a2(5,w),dimension=dim)
;a3=a2(*,w)
;w1=where(a3(14,*) gt 11)
;g03=griddata(a3(0,w1),a3(2,w1),a3(14,w1),dimension=dim)
;aa3=a3([0,2],w1)
;aa3(0,*)=aa3(0,*)*dim/(max(aa3(0,*))-min(aa3(0,*)))
;aa3(1,*)=aa3(1,*)*dim/(max(aa3(2,*))-min(aa3(2,*)))
;gaa=points2image(aa3,w=dim,h=dim)
;gab=byte((gaa-min(gaa))*255.0/(max(gaa)-min(gaa)))
g01=round((g01-min(g01))*255.0/14.0)
g02=round((g02-min(g02))*255.0/0.60)
;g03=round((g03-min(g03))*255.0/2.0)

if keyword_set(write) then begin
write_tiff,f01[j],g01
write_tiff,f02[j],g02
;write_tiff,f03[j],g03
;write_tiff,f04[j],g04
endif
a01(*,*,j)=g01
a02(*,*,j)=g02
;a03(*,*,j)=g03
;a04(*,*,j)=gab
endfor
end