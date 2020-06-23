dir = 'D:\liminhuan\s-s transition project\1003 data\f&b after\boo_descrete_res\'
;time = ['1002-boo-15_min-p2-frame','1002-boo-15_min-p2-frame','1002-boo-30_min-p2-frame','1002-boo-40_min-p2-frame']
time = ['1002-boo-15_min-p1-frame']
for i = 0, 0 do begin
   file = file_search(dir+time(i)+'*',count=nb)
   for t = 0, nb-1 do begin
     temp = read_gdf(file_search(dir+time(i)+strcompress(string(t),/remove)+'.gdf'))
     temp(17,*) = t
     write_gdf,temp,dir+time(i)+string(t)+'.gdf'
   endfor
   
endfor

end

