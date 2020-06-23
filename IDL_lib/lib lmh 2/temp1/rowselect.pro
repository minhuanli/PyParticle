function rowselect, data , target 
nn = n_elements(target(0,*))
res = [-1l]
for i = 0l,nn-1 do begin 
  w=where(data eq target(0,i))
  res = [[res],[transpose(w)]]
endfor

return, res(0,1:n_elements(res)-1)

end 