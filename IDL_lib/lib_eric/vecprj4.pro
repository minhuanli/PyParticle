;计算f(q),用q的方向，不用大小
pro vecprj4,evc,pos,tr,lo,bins=bins
n1=n_elements(evc)/2
evc01=reform(evc,2,n1)
ka=[0.01,3,14]*bins/256
kb=[0.01,3,14]*bins/256
kx=interpol(ka,bins+1)
ky=interpol(kb,bins+1)
kr=findgen(bins+1,bins+1)
tr1=findgen(bins+1,bins+1)
lo1=findgen(bins+1,bins+1)
for i=0,bins do begin
for j=0,bins do begin
kr(i,j)=sqrt(kx(i)^2+ky(j)^2)
for k=0,n1-1 do begin
ax=cos(kx(i)*pos(0,k))
ay=sin(ky(j)*pos(1,k))
ar=complex(ax,ay)
fk=complexarr(n1)
fk[k]=((kx(i)/kr(i,j))*evc01(0,k)+(ky(j)/kr(i,j))*evc01(1,k))*ar
ffk=complexarr(n1)
ffk[k]=((kx(i)/kr(i,j))*evc01(1,k)-(ky(j)/kr(i,j))*evc01(0,k))*ar
endfor
f1=total(abs(fk)^2)/n1
f2=total(abs(ffk)^2)/n1
tr1(i,j)=f1
lo1(i,j)=f2
endfor
print,i
endfor
tr=tr1
lo=lo1
end

