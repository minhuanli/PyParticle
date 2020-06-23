; bcc 1, hcp 2 , fcc 3, bcc-pre 4, hcp-pre 5, fcc-pre 6, ico 7, pure liquid 8 
function classify_voi,bond,tr33 
n=n_elements(bond(0,*))
result=fltarr(1,n)
if not (keyword_set(tr33)) then tr33=fltarr(5,n)

;----------------solid part----------------------------
w1=where(bond(5,*) ge 0.40 and bond(8,*) gt 0,nw1) ; bcc
w3=where(bond(5,*) ge 0.40 and bond(8,*) lt 0 and bond(7,*) lt 0,nw3) ;fcc
w2=where(bond(5,*) ge 0.40 and bond(8,*) lt 0 and bond(7,*) gt 0,nw2) ;hcp




if nw1 gt 0 then result(w1)=1
if nw2 gt 0 then result(w2)=2
if nw3 gt 0 then result(w3)=3

;--------------------precursor part--------------------
w4=where(bond(5,*) gt 0.25 and bond(5,*) lt 0.40 and bond(8,*) gt 0,nw4) ; bcc-pre
w6=where(bond(5,*) gt 0.25 and bond(5,*) lt 0.40 and bond(8,*) lt 0 and bond(7,*) lt 0,nw6) ;fcc-pre
w5=where(bond(5,*) gt 0.25 and bond(5,*) lt 0.40 and bond(8,*) lt 0 and bond(7,*) gt 0,nw5) ;hcp-pre


if nw4 gt 0 then result(w4)=4
if nw5 gt 0 then result(w5)=5
if nw6 gt 0 then result(w6)=6

;-------------------liquid part------------------------
w7=where(bond(5,*) lt 0.25 and tr33(4,*) gt 12, nw7)
w8=where(bond(5,*) lt 0.25 and tr33(4,*) le 12, nw8)

if nw7 gt 0 then result(w7)=7
if nw8 gt 0 then result(w8)=8
;--------------------------------------------

return, result

end
