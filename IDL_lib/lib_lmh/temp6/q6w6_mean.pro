dir1 = 'D:\liminhuan\s-s transition project\0809 data\boo\0809-boo-mf1\0809-boo-mf1-p       1-t*'
dir2 = 'D:\liminhuan\s-s transition project\0809 data\boo\0809-boo-mf2\0809-boo-mf2-p       1-t*'
file1= file_search(dir1)
file2= file_search(dir2)
file = [file1,file2]
res = fltarr(5,40)
for i = 0,39 do begin 
   bi = read_gdf(file(i))
   test = eclip(bi,[0,5,105],[1,5,55],[2,55,105])
   res(0,i) = i
   res(1,i) = mean(test(8,*))
   res(2,i) = stddev(test(8,*))
   res(3,i) = mean(test(5,*))
   res(4,i) = stddev(test(5,*))
endfor


end
   
  
