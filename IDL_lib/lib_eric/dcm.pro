;returns 2 d covariance matrix, input data should be complete tracked data.
function dcm,trb,dt=dt
mposition=meanposition(trb)
l=max(mposition(6,*))
t=max(mposition(5,*))
cm=findgen(2*(l+1),2*(l+1))

For j=0,l do begin
print,j
w11=where(mposition(6,*) eq j)
cmx=mposition(0,w11)
cmy=mposition(1,w11)
For i=0,l do begin
w12=where(mposition(6,*) eq i)
cmx1=mposition(0,w12)
cmy1=mposition(1,w12)
cm11=0.
cm12=0.
cm21=0.
cm22=0.

for k=0,t do begin
cm11=cm11+cmx[k]*cmx1[k]
cm12=cm12+cmy1[k]*cmx[k]
cm21=cm21+cmx1[k]*cmy[k]
cm22=cm22+cmy[k]*cmy1[k]
endfor
cm[2*j,2*i]=cm11/(t+1)
cm[2*j,2*i+1]=cm12/(t+1)
cm[2*j+1,2*i]=cm21/(t+1)
cm[2*j+1,2*i+1]=cm22/(t+1)
endfor
endfor
return,cm
end
