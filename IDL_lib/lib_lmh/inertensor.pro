function inertensor,npos,barycenter=barycenter
res = fltarr(3,3)
ii = [[1.,0,0],[0,1,0],[0,0,1]]
n = n_elements(npos(0,*))
if keyword_set(barycenter) then begin 
   npos(0,*) = npos(0,*) - mean(npos(0,*))
   npos(1,*) = npos(1,*) - mean(npos(1,*))
   npos(2,*) = npos(2,*) - mean(npos(2,*))
endif
for i = 0,n-1 do begin
  res = res + (transpose(npos(0:2,i))#npos(0:2,i))[0]*ii - (npos(0:2,i)#npos(0:2,i))
endfor

return,res

end
