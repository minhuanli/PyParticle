bf3 = read_gdf('D:\liminhuan\s-s transition project\1105 data\track_remove\btr_bf_p3.gdf')
bt0 = read_gdf('D:\liminhuan\s-s transition project\1105 data\track_remove\btr_p3_0min.gdf')
bt10 = read_gdf('D:\liminhuan\s-s transition project\1105 data\track_remove\btr_p3_10min.gdf')
bt20 = read_gdf('D:\liminhuan\s-s transition project\1105 data\track_remove\btr_p3_20min.gdf')
bt30 = read_gdf('D:\liminhuan\s-s transition project\1105 data\track_remove\btr_p3_30min.gdf')
bt40 = read_gdf('D:\liminhuan\s-s transition project\1105 data\track_remove\btr_p3_40min.gdf')
bt45 = read_gdf('D:\liminhuan\s-s transition project\1105 data\track_remove\btr_p3_45min.gdf')
bt70 = read_gdf('D:\liminhuan\s-s transition project\1105 data\track_remove\btr_p3_70min.gdf')


;
lind3dbf = lindman3d_lmh(edgecut(bf3,dc=2.0),nndr=2.0)
write_gdf,lind3dbf,'D:\liminhuan\s-s transition project\1105 data\lindemann_withw4\linp3_bf.gdf'

print,'1'

lind3d0 = lindman3d_lmh(edgecut(bt0,dc=2.5),nndr=2.0)
write_gdf,lind3d0,'D:\liminhuan\s-s transition project\1105 data\lindemann_withw4\linp3_0min.gdf'

print,'2'
;
lind3d0 = lindman3d_lmh(edgecut(bt10,dc=2.5),nndr=2.0)
write_gdf,lind3d0,'D:\liminhuan\s-s transition project\1105 data\lindemann_withw4\linp3_10min.gdf'

print,'3'
;
lind3d0 = lindman3d_lmh(edgecut(bt20,dc=2.5),nndr=2.0)
write_gdf,lind3d0,'D:\liminhuan\s-s transition project\1105 data\lindemann_withw4\linp3_20min.gdf'

lind3d0 = lindman3d_lmh(edgecut(bt30,dc=2.5),nndr=2.0)
write_gdf,lind3d0,'D:\liminhuan\s-s transition project\1105 data\lindemann_withw4\linp3_30min.gdf'

lind3d0 = lindman3d_lmh(edgecut(bt40,dc=2.5),nndr=2.0)
write_gdf,lind3d0,'D:\liminhuan\s-s transition project\1105 data\lindemann_withw4\linp3_40min.gdf'

print,'4'
lind3d0 = lindman3d_lmh(edgecut(bt70,dc=2.5),nndr=2.0)
write_gdf,lind3d0,'D:\liminhuan\s-s transition project\1105 data\lindemann_withw4\linp3_70min.gdf'

;
;
;bt2 = track1(bt,1.0,memory=0,dim=3,goodenough=10)
;mot = motion(bt2,dim=3,smoo=1)
;b2t2 = rm_motion(bt2,mot,dim=3,smooth=1)
;write_gdf,b2t2,'D:\liminhuan\s-s transition project\1003 data\f&b after\45_75_continue_res\pos4\p4track.gdf'

b2t2 = edgecut(bt45,dc=2.5)
lind3d20 = lindman3d_lmh(eclip(b2t2,[17,0,40]),nndr=2.0)
lind3d21 = lindman3d_lmh(eclip(b2t2,[17,20,60]),nndr=2.0)
lind3d22 = lindman3d_lmh(eclip(b2t2,[17,40,80]),nndr=2.0)
print,'5'
lind3d23 = lindman3d_lmh(eclip(b2t2,[17,80,120]),nndr=2.0)
lind3d24 = lindman3d_lmh(eclip(b2t2,[17,120,160]),nndr=2.0)
lind3d25 = lindman3d_lmh(eclip(b2t2,[17,140,180]),nndr=2.0)
print,'6'
lind3d26 = lindman3d_lmh(eclip(b2t2,[17,160,200]),nndr=2.0)

write_gdf,lind3d20,'D:\liminhuan\s-s transition project\1105 data\lindemann_withw4\linp3_45min.gdf'
write_gdf,lind3d21,'D:\liminhuan\s-s transition project\1105 data\lindemann_withw4\linp3_47min.gdf'
write_gdf,lind3d22,'D:\liminhuan\s-s transition project\1105 data\lindemann_withw4\linp3_50min.gdf'
write_gdf,lind3d23,'D:\liminhuan\s-s transition project\1105 data\lindemann_withw4\linp3_53min.gdf'
write_gdf,lind3d24,'D:\liminhuan\s-s transition project\1105 data\lindemann_withw4\linp3_58min.gdf'
write_gdf,lind3d25,'D:\liminhuan\s-s transition project\1105 data\lindemann_withw4\linp3_61min.gdf'
write_gdf,lind3d26,'D:\liminhuan\s-s transition project\1105 data\lindemann_withw4\linp3_65min.gdf'

end