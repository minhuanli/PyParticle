function valleysearch,data,min,max
w=where(data(0,*) ge min and data(0,*) le max,nw)
datas = data(*,w)
for i = 1,nw-2 do begin
  if  (datas(1,i) lt datas(1,i-1)) and (datas(1,i) lt datas(1,i+1)) then begin
      result = datas(0,i)
      break
  endif
endfor
return,result

end