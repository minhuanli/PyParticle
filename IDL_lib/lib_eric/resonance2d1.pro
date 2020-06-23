function resonance2d1,evs,evc,boo,number=number
na=n_elements(boo(3,*))
x1=boo(0,*)
y1=boo(1,*)
;z1=boo(2,*)
q6=boo(2,*)
w=where(q6 gt mean(q6),nb)
a2=findgen(2,number)
for j=0,number-1 do begin
bb01=reform(evc(*,j),2,na)
a=total(bb01(0,w)^2+bb01(1,w)^2)
a1=a*(na-nb)/(nb*(1.0-a))
a2(0,j)=1./abs(sqrt(evs[j]))
a2(1,j)=a1
endfor
return,a2
end

