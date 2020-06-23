;returns covariance matrix of incomplete tracked data.
function dcmtest,trb,dt=dt
mposition=meanposition(trb)
l=max(mposition(6,*))
t=max(mposition(5,*))
cm=findgen(2*(l+1),2*(l+1))
For j=0,l do begin
w11=where(mposition(6,*) eq j)
cmx=mposition(0,w11)
cmy=mposition(1,w11)
ta=mposition(5,w11)
n1=n_elements(ta)
For i=0,l do begin
w12=where(mposition(6,*) eq i)
cmx1=mposition(0,w12)
cmy1=mposition(1,w12)
tb=mposition(5,w12)
n2=n_elements(tb)
taa=fltarr(t+1)-1
for k=0,n2-1 do begin
w13=where(ta eq tb[k])
taa[k]=w13
endfor
w14=where(taa gt -1)
tab1=taa[w14]
tab=ta[tab1]
cm11=mean(cmx[tab]*cmx1[tab])
cm12=mean(cmy1[tab]*cmx[tab])
cm21=mean(cmx1[tab]*cmy[tab])
cm22=mean(cmy[tab]*cmy1[tab])
cm[2*j,2*i]=cm11
cm[2*j,2*i+1]=cm12
cm[2*j+1,2*i]=cm21
cm[2*j+1,2*i+1]=cm22
endfor
print,j
endfor
return,cm
end
