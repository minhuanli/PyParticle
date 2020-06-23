function grain_correlation1, qq1,qq2
 
  n=n_elements(qq1(*,0))
  nn=n_elements(qq2(*,0))
  if n ne nn then begin
    print,' qq1 qq2 size do not match '
    return,[0]
  endif
  n1=n_elements(qq1(0,*))
  n2=n_elements(qq2(0,*))
  result=fltarr(n1,n2)
   for i=0,n1-1 do begin
    for j=0,n2-1 do begin
      result(i,j)= real_part( mean( qq1(*,i) * conj(qq2(*,j)) /( abs(qq1(*,i)) * abs(qq2(*,j)) ) ) ) 
    endfor
   endfor

return,result

end
  
;================================================================================
;================================================================================  
; the method 2 is highly better
function grain_correlation2, qq1,qq2
 
  n=n_elements(qq1(*,0))
  nn=n_elements(qq2(*,0))
  if n ne nn then begin
    print,' qq1 qq2 size do not match '
    return,[0]
  endif
  n1=n_elements(qq1(0,*))
  n2=n_elements(qq2(0,*))
  result=fltarr(n1,n2)
   for i=0,n1-1 do begin
    for j=0,n2-1 do begin  
      temp=0 
      for k= 0,nn-1 do begin
        temp=temp + qq1(k,i)*conj(qq2(k,j))
      endfor
      qmi=sqrt(total((abs(qq1[*,i]))^2))
      qmj=sqrt(total((abs(qq2[*,j]))^2))
      result(i,j)= real_part(temp) /(qmi*qmj)
    endfor
   endfor

return,result

end
  