function nblist2d,a2,deltar=deltar,bondmax=bondmax
 triangulate,a2(0:1,*),triangles,connectivity=c1
 n1=n_elements(a2(0,*))
 list=lonarr(n1,bondmax+1)
 for j=0.,n1-1 do begin
  b1=c1[c1[j]:c1[j+1]-1]
  bx1=(a2(0,j)-a2(0,b1))^2+(a2(1,j)-a2(1,b1))^2
  w=where(bx1 lt deltar^2,nc)
  if nc gt 0 then begin
   list[j,0]=nc
   list[j,1:nc]=b1[w]
  endif
 endfor
 return,list
end
