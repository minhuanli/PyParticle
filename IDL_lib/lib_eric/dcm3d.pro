;returns 3 D covariance matrix, input data should be complete tracked data
function dcm3d,trb,dt=dt
mposition=meanposition3d(trb)
id1=mposition(8,*)
id2=id1[uniq(id1,sort(id1))]
l=n_elements(id2)-1
t=max(mposition(7,*))
cm=findgen(3*(l+1),3*(l+1))

For j=0,l do begin
w11=where(mposition(8,*) eq id2[j])
cmx=mposition(0,w11)
cmy=mposition(1,w11)
cmz=mposition(2,w11)
For i=0,l do begin
w12=where(mposition(8,*) eq id2[i])
cmx1=mposition(0,w12)
cmy1=mposition(1,w12)
cmz1=mposition(2,w12)
cm11=0.
cm12=0.
cm13=0.
cm21=0.
cm22=0.
cm23=0.
cm31=0.
cm32=0.
cm33=0.

for k=0,t do begin
cm11=cm11+cmx[k]*cmx1[k]
cm12=cm12+cmy1[k]*cmx[k]
cm13=cm13+cmx[k]*cmz1[k]
cm21=cm21+cmx1[k]*cmy[k]
cm22=cm22+cmy[k]*cmy1[k]
cm23=cm23+cmy[k]*cmz1[k]
cm31=cm31+cmz[k]*cmx1[k]
cm32=cm32+cmz[k]*cmy1[k]
cm33=cm33+cmz[k]*cmz1[k]
endfor
cm[3*j,3*i]=cm11/(t+1)
cm[3*j,3*i+1]=cm12/(t+1)
cm[3*j,3*i+2]=cm13/(t+1)
cm[3*j+1,3*i]=cm21/(t+1)
cm[3*j+1,3*i+1]=cm22/(t+1)
cm[3*j+1,3*i+2]=cm23/(t+1)
cm[3*j+2,3*i]=cm31/(t+1)
cm[3*j+2,3*i+1]=cm32/(t+1)
cm[3*j+2,3*i+2]=cm33/(t+1)
endfor
print,j
endfor
return,cm
end
