
f1=file_search('E:\temp1\voi&spt method\mix low tetra\mix low tr33*')
tr33c=read_gdf(f1(4))
for i=5,9 do begin
tempb= read_gdf(f1(i))
tr33c=[[tr33c],[tempb]]

endfor

end 