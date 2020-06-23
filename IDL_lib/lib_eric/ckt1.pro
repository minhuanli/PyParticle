function ckt1,pos1,pos2,evc
n1=n_elements(evc(0,*))
n2=n_elements(pos1(0,*))
dr1=pos2(0,*)-pos1(0,*)
dr2=pos2(1,*)-pos1(1,*)
dr3=findgen(2,n2)
dr3(0,*)=dr1
dr3(1,*)=dr2
dr4=reform(dr3,2*n2,1)
p=findgen(1,n1)
For i=0,n1-1 do begin
p2=total(evc(*,i)*dr4)
p[i]=p2
Endfor
w1=reverse(sort(p^2))
r2=total(dr4^2)
p1=p[w1]^2/r2
p3=p[w1]/1.0
ck1=findgen(6,n1)
ck1(0,*)=w1
ck1(1,*)=p1
ck1(2,*)=p3
ck1(3,*)=p^2/r2
ck1(4,*)=p^2/1.0
ck1(5,*)=total(ck1(3,*),/cumulative)
return,ck1
end