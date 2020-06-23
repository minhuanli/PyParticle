pro ubonds,triangles,bonds,tlist
;+
; NAME:
;		ubonds
; PURPOSE:
;		Converts a Delaunay triangulation into a list of unique
;		nearest neighbor bonds.
; CATEGORY:
;		Computational Geometry
; CALLING SEQUENCE:
;		ubonds,triangles,bonds,[tlist]
; INPUTS:
;		triangles:	(3,ntriangles) array of vertex indices
;			defining the Delaunay triangulation of a set.  This
;			set can be produced by DELAUNAY.
; OUTPUTS:
;		bonds:	(2,nbonds) array of vertex indices of the nearest
;			neighbor bonds arranged so that BONDS(0,i) <=
;			BONDS(1,i) and BONDS(0,i) <= BONDS(0,i+1)
;
; OPTIONAL OUTPUTS:
;		tlist: (2,nbonds) array of indices into the list of triangles
;			listing which triangles contain each bond.  If only
;			one triangle contains the n'th bond, then
;			tlist(1,n) is set to -1.
; PROCEDURE:
;		Converts each triangle into three bonds, each of which
;		consists of a pair of indices into the original list of
;		points.  This list is sorted so that bonds connecting
;		the same points are subsequent in the list.  At most
;		two triangles will contain each bond.  Then simply
;		work through the list recording the first of each pair.
;
; RESTRICTIONS:
;		Uses the astronomy routine BSORT to do the sorting in
;		a sensible fashion.
;
; MODIFICATION HISTORY:
;		Written by David G. Grier, AT&T Bell Laboratories, Aug. 1991.
;		9/91 modified to make use of HASH2.
;		10/14/92 DGG The University of Chicago.  Rewrote, using
;			BSORT to facilitate the production of TLIST.
;			Added TLIST.  Reference to HASH2 removed.
;-

t=transpose(triangles)
a=[t(*,0)<t(*,1),t(*,1)<t(*,2),t(*,2)<t(*,0)]
b=[t(*,0)>t(*,1),t(*,1)>t(*,2),t(*,2)>t(*,0)]
na = n_elements(a)
d = lindgen(na/3)
d = [d,d,d]
order = sort( b )
a = a(order)
b = b(order)
d = d(order)
order = bsort( a )
a = a(order)
b = b(order)
d = d(order)

n = 0
bonds = [a(0),b(0)]
tlist = [d(0),-1]
for i = 1, na - 1 do begin
	if a(i) eq a(i-1) and b(i) eq b(i-1) then $
		tlist(1,n) = d(i) $
	else begin
		bonds = [[bonds],[a(i),b(i)]]
		tlist = [[tlist],[d(i),-1]]
		n = n + 1
		endelse
	endfor
end
