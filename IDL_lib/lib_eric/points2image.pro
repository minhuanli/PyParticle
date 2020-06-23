function points2image,points,values,w=w,h=h,exact=exact
;+
; NAME:
;		points2image
; PURPOSE:
;		Creates an image with values distributed at discrete points.
;		If the point does not fall exactly on a grid point in the
;		image, the value is distributed among the neighboring grid
;		points proportionally to the mismatch.
; CATEGORY:
;		Image Processing
; CALLING SEQUENCE:
;		image = points2image(points,values)
; INPUTS:
;		points: (2,npts) array containing x and y coordinates for 
;			each point.
; KEYWORD PARAMETERS:
;		w,h:	width and height of the image
;		exact:  if set, then values are placed exactly at the specified
;			locations by distributing them proportionately into
;			the neighboring bins.
;
; OPTIONAL INPUT PARAMETERS:
;		values:	(npts) array containing the values to be assigned to
;			each point.  If not included, values are taken to be
;			single precision floating point of value 1.
; OUTPUTS:
;		image:	An image of the same type as values.
; MODIFICATION HISTORY:
;		Written by David G. Grier, AT&T Bell Laboratories, 8/91
;	3/9/95 DGG: Cut data which falls outside image window.
;-

s = size(points)
if( s(0) ne 2 ) then message,'data is not a valid set of points'
x = transpose(points(0,*))
y = transpose(points(1,*))

if not keyword_set(w) then w = fix(max(x)) + 1
if not keyword_set(h) then h = fix(max(y)) + 1

good = where( x ge 0. and x lt (w-1) and y ge 0. and y lt (h-1), ngood )
if ngood lt 1 then message,'no points inside image window'
x = x(good)
y = y(good)

xi = fix(x)			; integer parts of the locations
yi = fix(y)
xf = x - float(xi)		; fractional parts
yf = y - float(yi)
xfyf = xf*yf

if n_params() eq 1 then $
	values = fltarr(n_elements(x)) + 1.
s = size(values)
if s(0) ne 1 then message,'vector-valued fields are not supported'
case s(2) of
	1: data = bytarr(w,h)
	2: data = intarr(w,h)
	3: data = lonarr(w,h)
	4: data = fltarr(w,h)
	5: data = dblarr(w,h)
	6: data = complexarr(w,h)
	else: message,'values must be numerical'
	endcase
if keyword_set(exact) then begin
	data(xi,yi)	= data(xi,yi) + values * (1. - xf - yf + xfyf)
	data(xi+1,yi)	= data(xi+1,yi)	+ values * (xf - xfyf)
	data(xi,yi+1)	= data(xi,yi+1)	+ values * (yf - xfyf)
	data(xi+1,yi+1)	= data(xi+1,yi+1) + values * xfyf
	endif $
else $
	data(round(x),round(y)) = values
return,data
end
