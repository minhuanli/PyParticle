dir = 'D:\liminhuan\s-s transition project\1105 data\boo\boo_'
partlist = ['p3_45min']
for part = 0,0 do begin
   print,'aot concentration dynamic  ' + partlist(part)
   boo = catptdata(dir+partlist(part)+'*')
   boo = boo(0:17,*)
   bt = track1(boo,1.0,memory=1,goodenough=1,dim=3)
   mot = motion(bt,dim=3,smoo=1)
   btr = rm_motion(bt,mot,dim=3,smoo=1)
   ;write_gdf,btr,'D:\liminhuan\s-s transition project\aot_concentration_dynamic\track_remove\'+'btr_'+partlist(part)+'.gdf'
endfor
print,'aot concentration dynamic'

end