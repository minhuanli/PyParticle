pro distct,boo,tr,cr,pre,liq,ico

;--------cr--------
w=where(boo(3,*) ge 7,nw1)
if nw1 gt 0 then cr=boo(*,w)
;------pre---------
w=where(boo(5,*) gt 0.27 and boo(3,*) lt 7)
pre=boo(*,w)
;---------liq-------
w=where(boo(5,*) le 0.27 and boo(3,*) lt 7 and tr(4,*) le 12)
liq=boo(*,w)
;----------ico-------
w=where(tr(4,*) gt 12)
temp=boo(*,w)
w=where(temp(3,*) lt 7)
ico=temp(*,w)

end