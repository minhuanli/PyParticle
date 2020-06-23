; functional only for particles on xy plane
function poly_angle, trb=trb,zero=zero
    x0=mean(trb(0,*))
    y0=mean(trb(1,*))
    if keyword_set(zero) then x0=0.
    if keyword_set(zero) then y0=0.
    nn=n_elements(trb(0,*))
    result=fltarr(nn)
    for i=0 ,nn-1 do begin
       dy= trb(1,i)- y0
       dx= trb(0,i)- x0
       result(i)=atan( dy , dx)
    endfor
return, result
end