function ntsplitt,tr,n0
;tr=tr1
id=tr(3,*)
id=id(uniq(id,sort(id)))
nid=n_elements(id)
nt=tr(2,*)
ntt=nt(uniq(nt,sort(nt)))
ndt=n_elements(ntt)
nnt=fix(1.0*ndt/n0,type=3)
w=where(tr(2,*) lt 1.0*n0*nnt)
tr=tr(*,w)
na=n_elements(tr(0,*))
a1=ulindgen(na)
wb=reform(a1,n0,nnt*nid)
wc=transpose(wb(0,*))
tr1=tr(*,wc)
tr1(2,*)=tr1(2,*)/n0
print,nnt
print,nid
print,1.0*nnt/nid
return,tr1
end

