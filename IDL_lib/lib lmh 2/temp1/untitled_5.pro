file = file_search('D:\liminhuan\s-s transition project\0809 data\boo\0809-boo-mf1\0809-boo-mf1-p       4-t*')


for i = 0,10 do begin

b2 = read_gdf(file[i])

p2t0 = edgecut(b2)

w=where(p2t0(5,*) lt 0.35 or (p2t0(5,*) gt 0.35 and p2t0(8,*) gt 0))

plot_hist,p2t0(2,w),bin=.03,/ow

p2t0 = eclip(p2t0,[2,10,30])

w=where(p2t0(5,*) gt 0.35 and p2t0(8,*) gt -0.007 and p2t0(8,*) lt 0)

idcluster2,p2t0(*,w),c01,list=s01,deltar=2.3

write_gdf,s01,'D:\liminhuan\s-s transition project\0809 data\precluster\p4c'+string(i)+'.gdf'


w=where(p2t0(5,*) gt 0.35 and p2t0(8,*) gt 0)

idcluster2,p2t0(*,w),c01,list=s01,deltar=2.3

write_gdf,s01,'D:\liminhuan\s-s transition project\0809 data\bcccluster\b4c'+string(i)+'.gdf'




p2t0 = edgecut(b2)

w=where(p2t0(5,*) lt 0.35 or (p2t0(5,*) gt 0.35 and p2t0(8,*) gt 0))

plot_hist,p2t0(2,w),bin=.03,/ow

p2t0 = eclip(p2t0,[2,45,100])

w=where(p2t0(5,*) gt 0.35 and p2t0(8,*) gt -0.007 and p2t0(8,*) lt 0)

idcluster2,p2t0(*,w),c01,list=s01,deltar=2.3

write_gdf,s01,'D:\liminhuan\s-s transition project\0809 data\precluster\p4c2'+string(i)+'.gdf'


w=where(p2t0(5,*) gt 0.35 and p2t0(8,*) gt 0)

idcluster2,p2t0(*,w),c01,list=s01,deltar=2.3

write_gdf,s01,'D:\liminhuan\s-s transition project\0809 data\bcccluster\b4c2'+string(i)+'.gdf'

endfor

end