function bosonpeak,evc01,evs01,pos01,ratio,p6=p6
omg01=1./sqrt(abs(evs01(0:1999)))
ra01=findgen(4,2000)
n0=n_elements(pos01)/2
for j=0,1999 do begin
p01=psi6(pos01,polar=1)
p06=p01(0,*)
evc02=reform(evc01(*,j),2,n0)
w=where(p06 lt p6)
nn01=total((evc02(0,w))^2+(evc02(1,w))^2)
nn02=1.*n_elements(evc02(0,w))/n0
nn03=nn01/nn02
ra01(1,j)=nn01
ra01(2,j)=nn02
ra01(3,j)=nn03
end
ra01(0,*)=omg01
ratio=ra01
return,ratio
end
