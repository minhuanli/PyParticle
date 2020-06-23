function fractime, data 
ti = min(data(18,*))
tf = max(data(18,*))
nt = tf-ti + 1 
res = fltarr(4,nt) 
  for i = ti,tf do begin 
    res(0,i) = i 
    temp = eclip(data,[18,i,i])
    np = n_elements(temp(0,*))
    w=where(temp(5,*) gt 0.35 and temp(8,*) gt 0,nw)
    res(1,i) = np
    res(2,i) = nw 
    res(3,i) = float(nw)/np
  endfor
return, res

end