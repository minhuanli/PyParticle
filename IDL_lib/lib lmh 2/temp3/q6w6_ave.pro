res = fltarr(5,5)
for i = 0, 4 do begin 
  bi = eclip(bc,[18,i,i])
  res(0,i) = i 
  res(1,i) = mean(bi(5,*))
  res(2,i) = stddev(bi(5,*))
  res(3,i) = mean(bi(8,*))
  res(4,i) = stddev(bi(8,*))

endfor 

end 
   