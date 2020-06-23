function resonance2d,evs,evc,mob1,number=number
na=n_elements(mob1(0,*))
x1=mob1(0,*)
y1=mob1(1,*)
;z1=boo(2,*)
q6=mob1(2,*)
w=where(q6 gt mean(q6)and q6 le max(q6),nb)
a2=findgen(4,number)
for j=0,number-1 do begin
bb01=reform(evc(*,j),2,na)
a=total(bb01(0,w)^2+bb01(1,w)^2)
g01=total(q6(0,w))
g02=total(q6)
a1=a*(na-nb)/(nb*(1.0-a))
g03=a*na/nb
g04=(1.0-a)*na/(na-nb)
a2(0,j)=1./abs(sqrt(abs(evs[j])))
a2(1,j)=a1
a2(2,j)=g03
a2(3,j)=g04
endfor
return,a2
end

