dir = 'D:\liminhuan\s-s transition project\1105 data\boo\boo_'
partlist=['p3_70min']

for part = 0,0 do begin 
   file = file_search(dir + partlist(part) + '*',count= nb)
   
   for i = 22 ,22, 2 do begin
      bt = read_gdf(file(i))
      br = rotate1(bt,angle=-0.004,f1=0,f2=2)
      brc = edgecut(br,dc=2.0)
      brc = eclip(brc,[0,0,80],[1,0,80])
      slice = polycut(brc,f1=1,f2=2)
      povlmh_color,[slice(0:2,*),slice(8,*)],r = 0.94, minc=-0.015,maxc = 0.00001 ,name ='D:\liminhuan\s-s transition project\1105 data\figure2_test\pov2\'+ partlist(part) + string(i)+'.pov'
      write_text,slice,'D:\liminhuan\s-s transition project\1105 data\figure2_test\txt2\'+ partlist(part) + string(i)+'.txt'
   endfor
endfor

end
   