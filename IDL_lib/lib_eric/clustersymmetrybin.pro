;calculate tetra network cluster participation of each symmetry. 1 bcc 2 hcp , 3 fcc

function clustersymmetrybin,b01,tsize,tetrap
b01=symmetry(b01)
n1=n_elements(tsize(0,*))
s02=fltarr(4,n1)
;for j=0.,n1-1 do begin
;p01=transpose(tetrap(*,j))
w1=where(b01(13,*) eq 1,na)
if na gt 0 then begin
s02(0,*)=transpose(total(tetrap(w1,*),1))
endif
w2=where(b01(13,*) eq 2,nb)
if nb gt 0 then begin
s02(1,*)=transpose(total(tetrap(w2,*),1))
endif
w3=where(b01(13,*) eq 3,nc)
if nc gt 0 then begin
s02(2,*)=transpose(total(tetrap(w3,*),1))
endif
w4=where(b01(13,*) gt 0,nd)
if nd gt 0 then begin
s02(3,*)=transpose(total(tetrap(w4,*),1))
endif
w=where(s02(3,*) ne 0)
s02(0,w)=s02(0,w)/s02(3,w)
s02(1,w)=s02(1,w)/s02(3,w)
s02(2,w)=s02(2,w)/s02(3,w)
tsize1=[tsize,s02]
return,tsize1
end

