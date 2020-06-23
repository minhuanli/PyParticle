
file0 = 'D:\liminhuan\s-s transition project\0809 data\geometry step\0809-p1 fig\'
for timet = 1, 2 do begin
 if timet eq 1 then nn = 8 else nn = 2
  for time = 0 , 18 ,nn do begin 
  
  filet = file0 + '0809-lh-mf' + strcompress(string(timet),/remove) + 'p1-t' + strcompress(string(time),/remove) + '-all-solid-trunc'
  datat = readtext(file_search(filet+'*'))
  test = hist_2d(datat(4,*),datat(7,*),min1 = 1.2, max1 = 1.8, min2=0., max2 = 0.25, bin1=0.002,bin2 = 0.001)
  write_text,test,file0+'md_' + '0809-lh-mf' + strcompress(string(timet),/remove) + 'p1-t' + strcompress(string(time),/remove) + '-all-solid-trunc.txt'
  endfor
endfor

end
  