function dcm1,position,dt=dt
l=max(position(3,*))
t=max(position(2,*))
cm=findgen(2*(l+1),2*(l+1))

For j=0,l do begin
w11=where(position(3,*) eq j)
cmx=position(0,w11)
cmy=position(1,w11)
For i=0,l do begin
w12=where(position(3,*) eq i)
cmx1=position(0,w12)
cmy1=position(1,w12)
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
