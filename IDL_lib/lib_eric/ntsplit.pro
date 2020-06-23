function ntsplit,tr,n0
id=tr(3,*)
id=id(uniq(id,sort(id)))
nid=n_elements(id)
nt=tr(2,*)
ntt=nt(uniq(nt,sort(nt)))
ndt=n_elements(ntt)
nnt=round(1.0*ndt/n0)-1.0
;print,1.0*ndt/n0/nid/2
;dt1=1.0*n0*findgen(ndt)
;w=where(dt1 lt ndt-1,nnt)
;print,nnt
;dt1=dt1(w)
tr22=[0,0,0,0]
for j=0.,nnt-1 do begin
;print,j
w1=where(nt eq ntt[j*n0],np)
tr01=tr(*,w1)
;if np eq nid then begin
tr01(2,*)=j
;endif
;if np ne nid then begin
;tr01(2,*)=-1.0
;endif
tr22=[[tr22],[tr01]]
endfor
nb=n_elements(tr22(0,*))
tr1=tr22(*,1:nb-1)
tr33=[0,0,0,0]
for j=0,nid-1 do begin
wd=where(tr1(3,*) eq id[j])
tr33=[[tr33],[tr1(*,wd)]]
endfor
n33=n_elements(tr33(0,*))
tr1=tr33(*,1:n33-1)
print,nnt
print,nid
print,1.0*nnt/nid
return,tr1
end

