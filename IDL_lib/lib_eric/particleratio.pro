function particleratio,evc,a,b,c,d,e,f
n1=n_elements(evc(*,0))
evc1=evc(*,a:b)
evc01=rebin(evc1,n1,1)
p01=reform(evc01,2,n1/2)
p001=p01(0,*)^2+p01(1,*)^2
evc2=evc(*,c:d)
evc02=rebin(evc2,n1,1)
p02=reform(evc02,2,n1/2)
p002=p02(0,*)^2+p02(1,*)^2
evc3=evc(*,e:f)
evc03=rebin(evc3,n1,1)
p03=reform(evc03,2,n1/2)
p003=p03(0,*)^2+p03(1,*)^2
pa=findgen(3,n1/2)
pa(0,*)=p001
pa(1,*)=p002
pa(2,*)=p003
return,pa
end