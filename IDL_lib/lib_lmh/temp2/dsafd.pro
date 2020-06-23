file = file_search('D:\liminhuan\pre2solid fluc\simudata\lambda4-0.7tm_*')

for i = 0,60 do begin
  tempb = read_ascii(file(i))
  
  write_gdf,tempb.field1,'D:\liminhuan\pre2solid fluc\simudata\0_7tm'+string(i)+'.gdf'
  
endfor


end