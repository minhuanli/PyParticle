pro qt3dhist,tr,qa,qb,rmin=rmin,rmax=rmax,deltar=deltar
dn=(rmax-rmin+1)/deltar
a=rmin+findgen(dn)*deltar
a1=qt3d(tr,rmin)
n1=n_elements(a1(0,*))
bb=findgen(n1,dn)
bb(*,0)=transpose(a1(2,*))
for j=1,dn-1 do begin
a2=qt3d(tr,a[j])
bb(*,j)=transpose(a2(2,*))
endfor
qa=transpose(a1(0,*))
qb=bb
end
