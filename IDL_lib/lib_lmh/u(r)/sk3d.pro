;1/rn define the resolution, usually 100 times the lattice scale a 
;nn define the k sample size, usually 5 times rn  
function sk3d,pos,reso,rang
  start1=systime(/second)
  rn=reso
  nn=rang*rn
  
  nnmid=round(nn/2)
  n1=n_elements(pos(0,*))
  xab=dblarr(5,long(nn)^3)
  x1=(findgen(nn)-nnmid)
  y1=(findgen(nn)-nnmid)
  z1=(findgen(nn)-nnmid) 
  c=1./rn
  n1=n_elements(pos(0,*))
  b=complex(0,1)
  count=0l
  for i=0,nn-1 do begin
  for j=0,nn-1 do begin
  for k=0,nn-1 do begin
    xab(1,count)=c*x1[i]
    xab(2,count)=c*y1[j]
    xab(3,count)=c*z1[k]
    xab(4,count)=abs( total(exp(c*b*x1[i]*pos(0,*)+c*b*y1[j]*pos(1,*)+c*b*z1[k]*pos(2,*))) * total(exp(-c*b*x1[i]*pos(0,*)-c*b*y1[j]*pos(1,*)-c*b*z1[k]*pos(2,*))) )
    xab(0,count)=c*sqrt( x1[i]^2 + y1[j]^2 + z1[k]^2 )
    count=long(count)+1l
  endfor
  endfor
  endfor
  xab(4,*)=xab(4,*)/n1
  ;xab(nnmid,nnmid,nnmid)=1.
  endtime1=systime(/second)
  print,'sk3d running time',endtime1-start1
  return,xab
end
  