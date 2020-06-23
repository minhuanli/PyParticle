;find the full cluster id1 connected in dm1 
function idloop,dm1,id1
id2=id1
repeat begin
ida=idshell(dm1,id2)
na=n_elements(ida)
nb=n_elements(id2)
id2=ida
endrep until na eq nb
id3=id2
return,id2
end


