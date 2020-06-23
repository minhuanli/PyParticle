;find the connected shell of id1 in dm1
function idshell,dm1,id1
n1=n_elements(id1)
id2=id1
for j=0.,n1-1 do begin
c1=dm1(id2[j],*)
w=where(c1 eq -1,nc)
if nc gt 0 then begin
id2=[id2,w]
endif
endfor
id2=id2[uniq(id2,sort(id2))]
return,id2
end