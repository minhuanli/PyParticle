;+
; NAME: psi6
;
; PURPOSE: Calculate bond-orientational order parameter for a set of points.
;
; CATEGORY: Computational Geometry
;
; CALLING SEQUENCE:
; ans = psi6( points )
;
; INPUTS:
; points: (2,npoints) array of (x,y) locations
;
; OPTIONAL INPUTS:
; none.
;	
; KEYWORD PARAMETERS:
; polar: if non-zero returns psi6 as (2,npoints) array of magnitudes and
;	angles.
;
; OUTPUTS:
; p6: (npoints) array of values of psi6
;
; OPTIONAL OUTPUTS:
; none.
;
; COMMON BLOCKS:
; none.
;
; SIDE EFFECTS:
; none.
;
; RESTRICTIONS:
; Only works for two-dimensional data sets.
;
;
; PROCEDURE:
; Calls triangulate which calculates the unique nearest-neighbor bonds
; for the points.
;
; EXAMPLE:
;
; MODIFICATION HISTORY:
; Written by David G. Grier, The University of Chicago, 9/22/94
;	Modified DGG 10/19/94, uses connectivity list in TRIANGULATE.
;	Works with complex data 11/4/94.
;-

function psi6, points, polar = polar

npoints = n_elements( points(0,*) )
x = reform( points(0,*) )
y = reform( points(1,*) )
triangulate, x, y, tr, connectivity = list
avg = complexarr( npoints )

for i = 0L, npoints - 1 do begin
	nbr = list(list(i):list(i+1)-1)	
	nbr = nbr( where( nbr ne i, nn ) )	; bug in triangulate
	dx = x(nbr) - x(i)
	dy = y(nbr) - y(i)
	sixtheta = 6. * atan( dy, dx ) ; why arctan?
	p6 = complex( cos(sixtheta), sin(sixtheta) )
	avg(i) = total( p6 ) / n_elements( nbr )
	endfor

if keyword_set( polar ) then begin
	m6 = sqrt( float( avg * conj( avg ) ) )
	a6 = atan( imaginary( avg ), float( avg ) )
	avg = [transpose(m6), transpose(a6)]
	endif

return, avg
end
