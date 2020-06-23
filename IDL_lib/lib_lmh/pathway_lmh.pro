function pathway_lmh,class
result = fltarr(9)

w = where(class le 3,nsolid)
result(0) = float(nsolid) / n_elements(class)

w=where(class ge 4 and class le 6,npre)
result(1) = float(npre) / n_elements(class)

w=where(class ge 7,nliq)
result(2) = float(nliq) / n_elements(class)
;=======================================================
w=where(class eq 1,nbcc)
result(3) = float(nbcc) / float(nsolid)

w=where(class eq 2,nhcp)
result(4) = float(nhcp) / float(nsolid)

w=where(class eq 3,nfcc)
result(5) = float(nfcc) / float(nsolid)
;==============================================
w=where(class eq 4,nbccp)
result(6) = float(nbccp) / float(npre)

w=where(class eq 5,nhcpp)
result(7) = float(nhcpp) / float(npre)

w=where(class eq 6,nfccp)
result(8) = float(nfccp) / float(npre)

return,result

end

;=============================================
; f1 time index ; f2 class index
function pathwayt_lmh,data,f1=f1,f2=f2
tmin=min(data[f1,*])
tmax=max(data[f1,*])
result = fltarr(9,tmax-tmin+1)
s = 0 
for t = tmin,tmax do begin
  if t mod 10 eq 0 then print,t
  w=where(data(f1,*) eq t)
  classt = data(f2,w)
  result(*,s) = pathway_lmh(classt)
  s=s+1
endfor

return,result

end
  




