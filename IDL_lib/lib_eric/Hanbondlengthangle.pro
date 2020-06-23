pro Hanbondlengthangle,points,bnds,lengthangle
;+
; NAME:
;		bondlengths
; PURPOSE:
;		Determine the lenghts of bonds between a set of points
; CATEGORY:
;		Computational Geometry
; CALLING SEQUENCE:
;		bondlengths,points,bonds,lengths
; INPUTS:
;		points:	(2,npts) array of x and y coordinates of points.
;			points(0,i) is the x-coordinate of the i'th point.
;		bonds:	(2,nbonds) array of indices into POINTS indicating
;			which points are connected by each bond.
; OUTPUTS:
;		lengths: (nbonds) array of the Euclidean lengths of the
;			elements of BONDS.	
; COMMON BLOCKS:
;		none
; SIDE EFFECTS:
;		none
; RESTRICTIONS:
;		Only works for two-dimensional bonds
; PROCEDURE:
;		very straightforward
; MODIFICATION HISTORY:
;		written by David G. Grier, AT&T Bell Laboratories,4/91
;- Han Yilong add angle calculation

x = transpose(points(0,*))
y = transpose(points(1,*))
a = transpose(bnds(0,*))
b = transpose(bnds(1,*))
dx=float(x(a) - x(b))
dy=float(y(a) - y(b))
lengthangle = transpose([[(x(a)+x(b))/2],[(y(a)+y(b))/2],[sqrt(dx^2 + dy^2)],[atan(dy,dx)]])
;lengthangle = transpose([(x(a)+x(b))/2,[y(a)+y(b)]/2,[sqrt(dx^2 + dy^2)],[atan(dy,dx)]])
end
