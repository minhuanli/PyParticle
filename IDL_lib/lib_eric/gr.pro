function gr,points,radial=radial, w = w, h = h, values=values
;+
; NAME:
;   gr
; PURPOSE:
;   Calculate the normalized two-point
;   autocorrelation function for a discrete set of points.
;   Optionally average over angles.
; CATEGORY:
;   Image processing
; CALLING SEQUENCE:
;   result = gr(points)
; INPUTS:
;   points: (2,npts) array of coordinates
;     points(0,i): x-coordinate of ith point
;     points(1,i): y-coordinate of ith point
; OUTPUTS:
;   result: two-point correlation function. 
;     OPTIONAL: g(r) averaged over angles
;
; KEYWORD PARAMETERS:
;   radial: if set, then the correlation function is averaged
;     over angles.
;   w:  Width in pixels of the embedding array.
;   h:  Height in pixels of the embedding array.
;   values: Weights for individual points.
; RESTRICTIONS:
;   can be somewhat slow.
;   Much faster if w and h have small prime factors (like 2).
; PROCEDURE:
;   Calls AUTOCORRELATION
; MODIFICATION HISTORY:
;   Written by David G. Grier, AT&T Bell Laboratories, 9/91.
;   Uses modified version of AZIAVG (10/92)
;   Added keyword RADIAL 2/93
;   Added keywords W and H 3/93
;   Added keyword VALUES 1/95
;   Fixed normalization bug if not all points fit in window 9/96.
;-

on_error,2

if keyword_set( w ) and keyword_set( h ) then begin
  if keyword_set( values ) then $
    g = points2image( points, values, /exact, w=w, h=h ) $
  else $
    g = points2image( points, /exact, w=w, h=h )
  endif $
else begin
  if keyword_set( values ) then $
    g = points2image( points, values, /exact ) $
  else $
    g = points2image( points, /exact ) 
  endelse 

; points2image distributes a total weight of 1 for each point
; which fits in the window.  Use this to get the effective number
; of points.
npts = total(g)

g = autocorrelation( g )

area = float( n_elements( g ) )

if keyword_set( radial ) then g = aziavg(g)

; Normalize for the density of points
;
;npts = float( n_elements( points(0,*) ) )
; The above line is wrong if not all points fit in the window (DGG)
g = g * area * npts^(-2)

return,g
end
