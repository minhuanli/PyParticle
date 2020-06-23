function sq2variable,pos,var
n1=n_elements(pos(0,*))
xab=findgen(257,257)
x1=findgen(257)-128
y1=findgen(257)-128
c=2.0*!pi/512
n1=n_elements(pos(0,*))
nb1=abs(mean(var(0,*)))
b=complex(0,1)
for i=0,256 do begin
for j=0,256 do begin
xab(i,j)=abs(total((var(0,*)/nb1)*exp(c*b*x1[i]*pos(0,*)+c*b*y1[j]*pos(1,*)))*total((var(0,*)/nb1)*exp(-c*b*x1[i]*pos(0,*)+c*b*y1[j]*pos(1,*))))
endfor
endfor
xab(128,128)=0
xab=xab/n1
return,xab
end

