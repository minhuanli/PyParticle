function bosonpeak2,evc01,evs01,trb
omg01=1./sqrt(abs(evs01(0,*)))
n0=n_elements(evs01(0,*))/2
ra01=findgen(5,2.0*n0)
p01=mobility(trb)
p06=p01(2,*)
p05=p01(0:1,*)
w3=where(p05 (0,*) gt 20 and p05(0,*) lt 490 and p05(1,*) gt 20 and p05(1,*) lt 490)
p005=p05(*,w3)
p07=psi6(p005,polar=1)
p08=p07(0,*)
n2=n_elements(p08)
w1=where(p08 lt mean(p08) and p08 ge min(p08))
w=where(p06 gt mean(p06) and p06 le max(p06))
for j=0,2.0*n0-1 do begin
evc02=reform(evc01(*,j),2,n0)
evc002=evc02(*,w3)
n2=total(evc002(0,*)^2+evc002(1,*)^2)
n002=n_elements(evc002(0,*))/n0
nn01=total((evc02(0,w))^2+(evc02(1,w))^2)
nn02=1.*n_elements(evc02(0,w))/n0
nn03=nn01/nn02
nn04=(1.0-nn01)/(1.0-nn02)
nn001=total((evc002(0,w1))^2+(evc002(1,w1))^2)
nn002=1.*n_elements(evc002(0,w1))/n0
nn003=nn001/nn002
nn004=(n2-nn001)/(n002-nn002)
ra01(1,j)=nn03
ra01(2,j)=nn04
ra01(3,j)=nn003
ra01(4,j)=nn004
end
ra01(0,*)=omg01
ratio=ra01
return,ratio
end


