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

;--------------------------------------------------------;
;--------center layer angle; center layer distance; middle angle of the center layer; up layer angle; up layer distance; down layer angle; 
;-----down layer distance-----
function hex_angle,trb
    w=where(abs(trb(2,*)) lt 0.3)
    ang1=poly_angle(trb=trb(*,w),/zero)
    len1=fltarr(6)
    ang2=fltarr(6)
    ww=sort(ang1)
    ang1=ang1(ww)
     for i=0,5 do begin
        len1(i)=norm(trb(0:1,w(ww(i))))
        if i lt 5 then begin
          ang2(i)=(ang1(i)+ang1(i+1))/2.
        endif else begin
          ang2(i)=(ang1(5)+ang1(0)-2*!pi)/2.
        endelse
     endfor
    
    w=where(trb(2,*) gt 0.3,nw)
    ang3=[-1.,-1.,-1.,-1.,-1.,-1.]
    ang3(0:nw-1)=poly_angle(trb=trb(*,w),/zero)
    len3=fltarr(6)
     for i=0,nw-1 do begin
        len3(i)=norm(trb(0:1,w(i)))
     endfor
        
    w=where(trb(2,*) lt -0.3,nw)
    ang4=[-1.,-1.,-1.,-1.,-1.,-1.]
    ang4(0:nw-1)=poly_angle(trb=trb(*,w),/zero)
    len4=fltarr(6) 
     for i=0,nw-1 do begin
        len4(i)=norm(trb(0:1,w(i)))
     endfor
    return,[[ang1],[len1],[ang2],[ang3],[len3],[ang4],[len4]]
 
 end
    