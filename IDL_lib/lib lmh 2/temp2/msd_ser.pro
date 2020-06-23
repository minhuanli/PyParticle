
dir = 'D:\liminhuan\s-s transition project\aot_concentration_dynamic\track_remove\btr_'
partlist = ['20mMd1','20mMd2','50mMd1','50mMd2','70mMd1','70mMd2']

for part = 0, 5 do begin 
  ;if part eq 4 then max = 300 else max = 150
  bt = read_gdf(file_search(dir+partlist(part)+'*'))
  msdt = msd(bt,dim=3,maxtime=80,timestep=2.4)
  write_text,msdt,'D:\liminhuan\s-s transition project\aot_concentration_dynamic\msd\'+$
  'msd_'+partlist(part)+'.txt'
  
endfor
  
end 



