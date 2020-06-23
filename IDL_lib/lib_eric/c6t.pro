function C6t,trj1,trj2,dt

;if not keyword_set(mydts) then mydts=[0]
ndt=n_elements(dt)
res=complexarr(2,ndt);[total C6t, count]

t2=max(trj2[3,*])+1
p=where(dt lt t2,newndt)
;include missing point when memory>1 in track.pro
fulltrj1=complexarr(max(trj1[3,*])+1)
fulltrj1[trj1[3,*]]=complex( cos(6*trj1[2,*]), sin(6*trj1[2,*]) )
fulltrj2=complexarr(t2)
fulltrj2[trj2[3,*]]=complex( cos(6*trj2[2,*]), sin(6*trj2[2,*]) )

for i=0,newndt-1 do begin
 try=fulltrj1*conj(fulltrj2[dt[i]:t2-1])
 p=where(try ne 0,count)
 res[1,i]=count
 res[0,i]=total(try)
endfor

return,res
end