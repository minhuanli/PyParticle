;--------course-grain1 over the pesai6---------------
;----the course grain calculate the correlation of the center particle & its neighbour
;----------------------------------------
function psi6_cr1, points
	npoints = n_elements( points(0,*) )
	x = reform( points(0,*) )
	y = reform( points(1,*) )
	triangulate, x, y, tr, connectivity = list
	avg = complexarr( npoints )
    cg1 = fltarr( npoints )

	for i = 0, npoints - 1 do begin
		nbr = list(list(i):list(i+1)-1)	
		nbr = nbr( where( nbr ne i, nn ) )	; bug in triangulate
		dx = x(nbr) - x(i)
		dy = y(nbr) - y(i)
		sixtheta = 6. * atan( dy, dx ) ; why arctan?
		p6 = complex( cos(sixtheta), sin(sixtheta) )
		avg(i) = total( p6 ) / n_elements( nbr )
	endfor

	for i=0l, npoints -1 do begin
		nbr = list(list(i):list(i+1)-1)	
		nbr = nbr( where( nbr ne i, nn ) )
		temp= avg(i) * conj(avg(nbr)) / ((sqrt(avg(i) * conj(avg(i)))) * (sqrt( avg(nbr) * conj(avg(nbr)))))
		cg1(i)=abs( total(temp) ) / n_elements( nbr )
	endfor
return, cg1
end
