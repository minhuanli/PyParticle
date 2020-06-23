res = fltarr(4,40)
for i = 0,39 do begin
  temp = eclip(bc,[17,i,i])
  w1 = where(temp(5,*) gt 0.33 and temp(8,*) lt 0,nw1)
  w2 = where(temp(5,*) lt 0.33,nw2)
  w3 = where(temp(5,*) gt 0.33 and temp(8,*) gt 0,nw3)
  res(1,i) = float(nw1)/n_elements(temp(0,*))
  res(2,i) = float(nw2)/n_elements(temp(0,*))
  res(3,i) = float(nw3)/n_elements(temp(0,*))
  res(0,i) = i
endfor

end  
