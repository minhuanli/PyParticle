pro distct2,boo,tr,cr,pre,liq,ico

;--------cr--------
w=where((boo(14,*)-boo(3,*)) le 1,nw1)
if nw1 gt 0 then cr=boo(*,w)
;------pre---------
w=where(boo(5,*) gt 0.27 and (boo(14,*)-boo(3,*)) gt 1)
pre=boo(*,w)
;---------liq-------
w=where(boo(5,*) le 0.27 and (boo(14,*)-boo(3,*)) gt 1 and tr(4,*) le 12)
liq=boo(*,w)
;----------ico-------
w=where(boo(5,*) le 0.27 and (boo(14,*)-boo(3,*)) gt 1 and tr(4,*) gt 12)
ico=boo(*,w)

end