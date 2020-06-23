function fqw,fqwtr,evc01,fqtrnew
omg01=1./sqrt(evc01(0:499))
h01=histogram(omg01,binsize=0.1,locations=lc01)
n1=n_elements(lc01)
fqtrnew=findgen(64,n1-1)
fqwtra=fqwtr
for j=0,n1-2 do begin
w=where(omg01 ge lc01(j) and omg01 lt lc01(j+1))
f1=fqwtra(*,w)
f2=rebin(f1,64,1)
fqtrnew(*,j)=f2
endfor
return,fqtrnew
end

