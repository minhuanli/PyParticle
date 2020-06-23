function qqcorrelation, qq1,qq2
 
  n=n_elements(qq1(*,0))
  nn=n_elements(qq2(*,0))
  if n ne nn then begin
    print,' qq1 qq2 size do not match '
    return,[0]
  endif

      temp=0 
      for k= 0,nn-1 do begin
        temp=temp + qq1(k)*conj(qq2(k))
      endfor
      qmi=sqrt(total((abs(qq1[*]))^2))
      qmj=sqrt(total((abs(qq2[*]))^2))
      result = abs(real_part(temp)) /(qmi*qmj)

return,result

end
;------------------------------------------------------------

function mismatch1, trb=trb,qqa=qqa,rmax=rmax,nmax=nmax
  n=n_elements(trb(0,*))
  list=conlist111(trb,deltar=rmax,bondmax=nmax)
  output=fltarr(1,n)
  for i= 0.,n-1 do begin
    nn=list(i,0)
    if nn lt 4 then continue 
    for j= 1, nn do begin
       output(i)=output(i)+qqcorrelation( qqa(*,i),qqa(*,list(i,j)) )
    endfor
    output(i)=output(i)/float(nn)
    output(i)=1.- output(i)
  endfor
  return,output
end