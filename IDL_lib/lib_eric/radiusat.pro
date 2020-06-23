function radiusat,tr,dr=dr
tr2=tr
sa=size(tr)
n1=n_elements(tr(0,*))
tr1=fltarr(8,n1)
tr1(0:2,*)=tr(0:2,*)
tr1(7,*)=tr(sa[1]-1,*)
t1=max(tr(sa[1]-1,*))-min(tr(sa[1]-1,*))+1.0
ta=findgen(t1)+min(tr(sa[1]-1,*))
for j=0, t1-1 do begin
w=where(tr(sa[1]-1,*) eq ta[j])
r01=radiusa(tr2(*,w),dr=dr)
tr1(3,w)=r01(3,*)
tr1(4,w)=r01(4,*)
tr1(5,w)=r01(5,*)
tr1(6,w)=r01(6,*)
print,j
endfor
return,tr1
end