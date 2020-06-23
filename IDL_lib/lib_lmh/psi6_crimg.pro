;--------correlation over the pesai6 imaginary part---------------
;-----------------------------------------------------------------
function psi6_crimg, points
  npoints = n_elements( points(0,*) )
  x = reform( points(0,*) )
  y = reform( points(1,*) )
  triangulate, x, y, tr, connectivity = list
  avg = complexarr( npoints )
  cg1 = fltarr( npoints )

  for i = 0l, npoints - 1 do begin
    nbr = list(list(i):list(i+1)-1) 
    nbr = nbr( where( nbr ne i, nn ) )  ; bug in triangulate
    dx = x(nbr) - x(i)
    dy = y(nbr) - y(i)
    sixtheta = 6. * atan( dy, dx ) 
    p6 = complex( cos(sixtheta), sin(sixtheta) )
    avg(i) = total( p6 ) / n_elements( nbr )

  endfor
    
    m6 = sqrt( float( avg * conj( avg ) ) )
    a6 = atan( imaginary( avg ), float( avg ) )
    avg = [transpose(m6), transpose(a6)]
    
  for i=0l, npoints -1 do begin
    nbr = list(list(i):list(i+1)-1) 
    nbr = nbr( where( nbr ne i, nn ) )
    temp= total( abs( avg(1,i) - avg(1,nbr)) ) 
    cg1(i)=temp / n_elements( nbr)
  endfor
return, cg1
end
