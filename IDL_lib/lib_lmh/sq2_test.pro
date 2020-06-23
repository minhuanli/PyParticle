;1/rn define the resolution, usually 100 times the lattice scale a 
;nn define the k sample size, usually 5 times rn  
function sq2_test,pos,rn,nn
nnmid=round(nn/2)
n1=n_elements(pos(0,*))
xab=findgen(nn,nn)
x1=(findgen(nn)-nnmid)
y1=(findgen(nn)-nnmid) 
c=2.0*!pi/rn
n1=n_elements(pos(0,*))
b=complex(0,1)
for i=0,nn-1 do begin
for j=0,nn-1 do begin
xab(i,j)=abs(total(exp(c*b*x1[i]*pos(0,*)+c*b*y1[j]*pos(1,*)))*total(exp(-c*b*x1[i]*pos(0,*)-c*b*y1[j]*pos(1,*))))
endfor
endfor
xab(nnmid,nnmid)=0
xab=xab/n1
return,xab
end

