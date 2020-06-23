;from positions to nearby tetras, input: pos should be indice of postitions, tr1 is the tetra 
;files which contains their tetracity from tetra_qhull data in tr1(5,*)
function postotetra,pos1,tr1
;tr1=tr1(0:3,*)
n1=n_elements(pos1)
tr3=fltarr(9,1)
for j=0.,n1-1 do begin
w1=where(tr1(0,*) eq pos1[j] or tr1(1,*) eq pos1[j] or tr1(2,*) eq pos1[j] or tr1(3,*) eq pos1[j],na)
if na gt 0 then begin
tr2=tr1(*,w1)
tr3=[[tr3],[tr2]]
endif
endfor
n2=n_elements(tr3(0,*))
tr3=tr3(*,1:n2-1)
return,tr3
end
