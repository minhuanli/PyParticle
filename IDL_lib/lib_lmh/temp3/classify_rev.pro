; bcc 1, hcp 2 , fcc 3, bcc-pre 4, hcp-pre 5, fcc-pre 6, ico 7, pure liquid 8 
function classify_rev,bondv,bonds12,tr33
n=n_elements(bondv(0,*))
result=fltarr(1,n)
if not (keyword_set(tr33)) then tr33=fltarr(5,n)

b0x=bonds12[10,*]-0.12500
b0y=bonds12[13,*]+0.2
b0k=b0y/b0x



;----------------solid part----------------------------
w1=where(bondv(5,*) ge 0.35 and bondv(8,*) gt 0,nw1) ; bcc
w3=where(bondv(5,*) ge 0.35 and bondv[8,*] lt 0 and b0x gt 0 and b0k lt 0.4/0.125,nw3) ;fcc
w21=where(bondv(5,*) ge 0.35 and bondv[8,*] lt 0 and b0k ge 0.4/0.125,nw21) ;hcp
w22=where(bondv(5,*) ge 0.35 and bondv[8,*] lt 0 and b0x le 0,nw22) ;hcp

w2=[w21,w22]
nw2=nw21+nw22

if nw1 gt 0 then result(w1)=1
if nw2 gt 0 then result(w2)=2
if nw3 gt 0 then result(w3)=3

;--------------------precursor part--------------------
w4=where(bondv(5,*) ge 0.25 and bondv(5,*) lt 0.35 and bondv(8,*) gt 0,nw4) ; bcc-pre
w6=where(bondv(5,*) ge 0.25 and bondv(5,*) lt 0.35 and bondv[8,*] lt 0 and b0x gt 0 and b0k lt 0.4/0.1225,nw6) ;fcc-pre
w51=where(bondv(5,*) ge 0.25 and bondv(5,*) lt 0.35 and bondv[8,*] lt 0 and b0k ge 0.4/0.1225,nw51) ;hcp-pre
w52=where(bondv(5,*) ge 0.25 and bondv(5,*) lt 0.35 and bondv[8,*] lt 0 and b0x le 0,nw52) ;hcp-pre

w5=[w51,w52]
nw5=nw51+nw52

if nw4 gt 0 then result(w4)=4
if nw5 gt 0 then result(w5)=5
if nw6 gt 0 then result(w6)=6

;-------------------liquid part------------------------
w7=where(bondv(5,*) lt 0.25 and tr33(4,*) gt 12, nw7)
w8=where(bondv(5,*) lt 0.25 and tr33(4,*) le 12, nw8)

if nw7 gt 0 then result(w7)=7
if nw8 gt 0 then result(w8)=8
;--------------------------------------------



return, result

end
