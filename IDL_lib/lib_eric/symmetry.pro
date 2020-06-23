;in the 13 th column, 1 is bcc, 2 is hcp, 3 is fcc
function symmetry, boo
n1=n_elements(boo(0,*))
b01=boo
b01(13,*)=0.0
w1=where(b01(14,*) gt 13,n1)
if n1 gt 0 then begin
b01(13,w1)=1.0
endif
w2=where(b01(14,*) gt 11 and b01(14,*) lt 13,n2)
if n2 gt 0 then begin
b202=b01(*,w2)
b01(13,w2)=2.0
b0x=b202(8,*)-0.1
b0y=b202(10,*)+0.2
b0z=b0y/b0x
w3=where(b0x gt 0 and b0z lt 0.4/0.15,n3)
if n3 gt 0 then begin
b01(13,w2[w3])=3.0
endif
endif
return,b01
end
