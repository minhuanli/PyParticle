function cal_self_correlation,bond1,bond2
n=n_elements(bond1[0,*])
n1=n_elements(bond1[*,0])
nn=n_elements(bond2[0,*])
nn1=n_elements(bond2[*,0])
result=fltarr(n,nn)
for i=0.,n-1 do begin
 for j=0.,nn-1 do begin
  result[i,j]=cal_corelation(bond1[3:n1-1,i],bond2[3:nn1-1,j])
 endfor
endfor
return,result
end