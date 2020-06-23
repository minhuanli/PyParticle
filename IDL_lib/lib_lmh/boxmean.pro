; output a matrix, whose elements are averaged parameter value
; ff[0] and ff[1] are parameter id to establish a 2d plane, and ff[2] are target parameters
; bin1 and bin2 have literal meaning
; example: res = boxmean(data = b4,ff=[0,1,18],bin1=1,bin2=1)
function boxmean,data=data,ff=ff,bin1=bin1,bin2=bin2
  xmax = max(data(ff[0],*))
  xmin = min(data(ff[0],*))
  ymax = max(data(ff[1],*))
  ymin = min(data(ff[1],*))
  
  xnn = ceil((xmax-xmin)/bin1)
  ynn = ceil((ymax-ymin)/bin2)
  result = fltarr(xnn,ynn)
  
  for i = 0, xnn-1 do begin
     for j = 0, ynn-1 do begin
        w=where(data(ff[0],*) gt xmin+i*bin1 and data(ff[0],*) lt xmin+(i+1)*bin1 and data(ff[1],*) gt ymin+j*bin2 and data(ff[1],*) lt ymin+(j+1)*bin2,nw)
        if nw eq 0 then continue
        result[i,j] = mean(data(ff[2],w))
     endfor
  endfor
  
  return,result

end