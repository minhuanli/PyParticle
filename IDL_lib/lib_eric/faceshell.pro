;find tetra shell woth adjacent face
function faceshell,tr1,id1
tr1=tr1(0:3,*)
n1=n_elements(id1)
ida=id1
id2=tr1(*,id1)
idb=id2
for j=0.,n1-1 do begin
c1=id2(*,j)
w=where(tr1(0,*) eq c1[0] or tr1(1,*) eq c1[0] or tr1(2,*) eq c1[0] or tr1(3,*) eq c1[0] or tr1(0,*) eq c1[1] or tr1(1,*) eq c1[1] or tr1(2,*) eq c1[1] or tr1(3,*) eq c1[1],na)
if na gt 0 then begin
tr2=tr1(*,w)
;c2=fltarr(na)
;idaa=id1[j]
for i=0.,na-1 do begin
s1=faceadj(c1,tr2(*,i))
if s1 eq 1 then ida=[ida,w[i]]
if s1 eq 1 then idb=[[idb],[tr1(*,w[i])]]
endfor
endif
endfor
idc=ida[uniq(ida,sort(ida))]
return,idc
end

