function dcm2,trb,dt=dt
mposition=meanposition(trb)
dim1=n_elements(trb(*,0))
l=max(mposition(dim1-1,*))
t=max(mposition(dim1-2,*))
cm=findgen(2*(l+1),2*(l+1))

For j=0,l do begin
print,j
w11=where(mposition(dim1-1,*) eq j)
cmx=mposition(0,w11)
cmy=mposition(1,w11)
For i=0,l do begin
w12=where(mposition(dim1-1,*) eq i)
cmx1=mposition(0,w12)
cmy1=mposition(1,w12)
w13=indgen(1+t)
cm11=cmx[w13]*cmx1[w13]
cm12=cmy1[w13]*cmx[w13]
cm21=cmx1[w13]*cmy[w13]
cm22=cmy[w13]*cmy1[w13]
cm[2*j,2*i]=mean(cm11)
cm[2*j,2*i+1]=mean(cm12)
cm[2*j+1,2*i]=mean(cm21)
cm[2*j+1,2*i+1]=mean(cm22)
endfor
endfor
return,cm
end
