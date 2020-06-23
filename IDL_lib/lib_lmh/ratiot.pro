function ratiot,alldata,seledata
ncol = n_elements(alldata(*,0))
alldata = alldata(*,sort(alldata(ncol-1,*)))
tlist = alldata(ncol-1,uniq(alldata(ncol-1,*)))
nt = n_elements(tlist(0,*))
res = fltarr(4,nt)
for t = 0, nt-1 do begin
  w1 = where(alldata(ncol-1,*) eq tlist(t),nw1)
  w2 = where(seledata(ncol-1,*) eq tlist(t),nw2)
  res(0,t) = tlist(t)
  res(1,t) = nw1
  res(2,t) = nw2
  res(3,t) = float(nw2)/float(nw1)
endfor

return,res

end