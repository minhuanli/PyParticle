function rowaverage, data

nn = n_elements(data(*,0))

res = fltarr(nn)

for i = 0, nn-1 do begin 
   res(i) = mean(data(i,*))
endfor

return,res

end


;==========================

function add_par, odata,f1=f1,f2=f2
   nb = polycut(odata,f1=f1,f2=f2,/iso)
   temp = rowaverage(nb)
   res = [[odata],[temp]]
return,res

end









