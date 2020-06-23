dir1 = 'D:\liminhuan\s-s transition project\1003 data\f&b after\boo_descrete_res\'
dir2 = 'D:\liminhuan\s-s transition project\1003 data\f&b after\45_75_continue_res\'
file = ['1002-boo-0_min-p2-frame','1002-boo-15_min-p2-frame','1002-boo-30_min-p2-frame','1002-boo-40_min-p2-frame','boo_pos 2_t']

for i = 0,4 do begin

if i eq 4 then dir = dir2 else dir = dir1

bond = catptdata(dir+file(i)+'*')
bond = bond(0:17,*)

bt = track1(bond,1.0,memory=1,dim=3,goodenough=1)
mot = motion(bt,dim=3,smoo=1)
btr = rm_motion(bt,mot,dim=3,smoo=1)

write_gdf,btr,'D:\liminhuan\s-s transition project\1003 data\f&b after\boo_descrete_res\pos2\'+'pos2_track'+string(i)+'.gdf'

endfor

end