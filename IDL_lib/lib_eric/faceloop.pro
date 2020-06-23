;find all tetras with adjacent face
function faceloop,tr1,id1
tr1=tr1(0:3,*)
id2=id1
repeat begin
idc=faceshell(tr1,id2)
na=n_elements(idc)
nb=n_elements(id2)
id2=idc
endrep until na eq nb
id3=id2
return,id2
end
