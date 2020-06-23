;b4t = track1(b4,1.0,memory=0,dim=3,goodenough=10)
;mot = motion(b4t,dim=3,smoo=1)
;b4t1 = rm_motion(b4t,mot,dim=3,smooth=1)
;write_gdf,b4t1,'D:\liminhuan\s-s transition project\1003 data\f&b before\pos4\p4track.gdf'
;
;
;b40t = track1(b40,1.0,memory=0,dim=3,goodenough=10)
;mot = motion(b40t,dim=3,smoo=1)
;b40t1 = rm_motion(b40t,mot,dim=3,smooth=1)
;write_gdf,b40t1,'D:\liminhuan\s-s transition project\1003 data\f&b after\boo_descrete_res\pos4\p4track0.gdf'
;
;b415t = track1(b415,1.0,memory=0,dim=3,goodenough=10)
;mot = motion(b415t,dim=3,smoo=1)
;b415t1 = rm_motion(b415t,mot,dim=3,smooth=1)
;write_gdf,b415t1,'D:\liminhuan\s-s transition project\1003 data\f&b after\boo_descrete_res\pos4\p4track15.gdf'
;
;b430t = track1(b430,1.0,memory=0,dim=3,goodenough=10)
;mot = motion(b430t,dim=3,smoo=1)
;b430t1 = rm_motion(b430t,mot,dim=3,smooth=1)
;write_gdf,b430t1,'D:\liminhuan\s-s transition project\1003 data\f&b after\boo_descrete_res\pos4\p4track30.gdf'
;
;b440t = track1(b440,1.0,memory=0,dim=3,goodenough=10)
;mot = motion(b440t,dim=3,smoo=1)
;b440t1 = rm_motion(b440t,mot,dim=3,smooth=1)
;write_gdf,b440t1,'D:\liminhuan\s-s transition project\1003 data\f&b after\boo_descrete_res\pos4\p4track40.gdf'


b4t1 = read_gdf('D:\liminhuan\s-s transition project\1003 data\f&b before\pos4\p4track.gdf')
b40t1 = read_gdf('D:\liminhuan\s-s transition project\1003 data\f&b after\boo_descrete_res\pos4\p4track0.gdf')
b415t1 = read_gdf('D:\liminhuan\s-s transition project\1003 data\f&b after\boo_descrete_res\pos4\p4track15.gdf')
b430t1 = read_gdf('D:\liminhuan\s-s transition project\1003 data\f&b after\boo_descrete_res\pos4\p4track30.gdf')
b440t1 = read_gdf('D:\liminhuan\s-s transition project\1003 data\f&b after\boo_descrete_res\pos4\p4track40.gdf')
b2t2 = read_gdf('D:\liminhuan\s-s transition project\1003 data\f&b after\45_75_continue_res\pos4\p4track.gdf')



lind3d0 = lindman3d_lmh(edgecut(b4t1,dc=2.5),nndr=2.0)
write_gdf,lind3d0,'D:\liminhuan\s-s transition project\1003 data\lindemann res\p4with_q6_w6\lin3d.gdf'



lind3d0 = lindman3d_lmh(edgecut(b40t1,dc=2.5),nndr=2.0)
write_gdf,lind3d0,'D:\liminhuan\s-s transition project\1003 data\lindemann res\p4with_q6_w6\lin3d0.gdf'

lind3d15 = lindman3d_lmh(edgecut(b415t1,dc=2.5),nndr=2.0)
write_gdf,lind3d15,'D:\liminhuan\s-s transition project\1003 data\lindemann res\p4with_q6_w6\lin3d15.gdf'

lind3d30 = lindman3d_lmh(edgecut(b430t1,dc=2.5),nndr=2.0)
write_gdf,lind3d30,'D:\liminhuan\s-s transition project\1003 data\lindemann res\p4with_q6_w6\lin3d30.gdf'

lind3d40 = lindman3d_lmh(edgecut(b440t1,dc=2.5),nndr=2.0)
write_gdf,lind3d40,'D:\liminhuan\s-s transition project\1003 data\lindemann res\p4with_q6_w6\lin3d40.gdf'


;
;
;bt2 = track1(bt,1.0,memory=0,dim=3,goodenough=10)
;mot = motion(bt2,dim=3,smoo=1)
;b2t2 = rm_motion(bt2,mot,dim=3,smooth=1)
;write_gdf,b2t2,'D:\liminhuan\s-s transition project\1003 data\f&b after\45_75_continue_res\pos4\p4track.gdf'

b2t2 = edgecut(b2t2,dc=2.5)
lind3d20 = lindman3d_lmh(eclip(b2t2,[17,0,50]),nndr=2.0)
lind3d21 = lindman3d_lmh(eclip(b2t2,[17,30,80]),nndr=2.0)
lind3d22 = lindman3d_lmh(eclip(b2t2,[17,50,100]),nndr=2.0)
lind3d23 = lindman3d_lmh(eclip(b2t2,[17,80,130]),nndr=2.0)
lind3d24 = lindman3d_lmh(eclip(b2t2,[17,100,150]),nndr=2.0)
lind3d25 = lindman3d_lmh(eclip(b2t2,[17,130,180]),nndr=2.0)
lind3d26 = lindman3d_lmh(eclip(b2t2,[17,150,200]),nndr=2.0)

write_gdf,lind3d20,'D:\liminhuan\s-s transition project\1003 data\lindemann res\p4with_q6_w6\lindd45.gdf'
write_gdf,lind3d21,'D:\liminhuan\s-s transition project\1003 data\lindemann res\p4with_q6_w6\lindd50.gdf'
write_gdf,lind3d22,'D:\liminhuan\s-s transition project\1003 data\lindemann res\p4with_q6_w6\lindd55.gdf'
write_gdf,lind3d23,'D:\liminhuan\s-s transition project\1003 data\lindemann res\p4with_q6_w6\lindd60.gdf'
write_gdf,lind3d24,'D:\liminhuan\s-s transition project\1003 data\lindemann res\p4with_q6_w6\lindd65.gdf'
write_gdf,lind3d25,'D:\liminhuan\s-s transition project\1003 data\lindemann res\p4with_q6_w6\lindd70.gdf'
write_gdf,lind3d26,'D:\liminhuan\s-s transition project\1003 data\lindemann res\p4with_q6_w6\lindd75.gdf'
end