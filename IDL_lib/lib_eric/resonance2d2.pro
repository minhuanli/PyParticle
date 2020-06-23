function resonance2d2,evs,evc,boo,number=number,p6=p6
na=n_elements(boo(1,*))
x1=boo(0,*)
y1=boo(1,*)
;z1=boo(2,*)
q6=boo(2,*)
w=where(q6 lt p6,nb)
w1=where(q6 ge p6 and p6 le 1.0,nb1)
a2=findgen(3,number)
for j=0,number-1 do begin
bb01=reform(evc(*,j),2,na)
a=total(bb01(0,w)^2+bb01(1,w)^2)
aa=total(bb01(0,w1)^2+bb01(1,w1)^2)
a1=a*(na-nb)/(nb*(1.0-a))
aa1=aa*(na-nb1)/(nb1*(1.0-aa))
a2(0,j)=1./abs(sqrt(evs[j]))
a2(1,j)=a1
a2(2,j)=aa1
endfor
return,a2
end

