;0,time 1,solid per 2,pre per 
res_boo1 = fltarr(4,500)
boo1c = edgecut(boo3)
for t = 0,499 do begin
  bondt = eclip(boo1c,[15,t,t])
  classt = bondt(16,*)
  n = n_elements(bondt(0,*))
  w = where(classt le 3,nw)
  ww = where(classt ge 4 and classt le 6,nww)
  www = where(classt eq 7,nwww)
  res_boo1(0,t) = t
  res_boo1(1,t) = float(nw)/float(n)
  res_boo1(2,t) = float(nww)/float(n)
  res_boo1(3,t) = float(nwww)/float(n)
endfor

end