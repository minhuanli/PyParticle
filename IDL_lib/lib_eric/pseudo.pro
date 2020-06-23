; $Id: //depot/idl/IDL_71/idldir/lib/pseudo.pro#1 $
;
; Copyright (c) 1982-2009, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.

PRO	PSEUDO,LITLO,LITHI,SATLO,SATHI,HUE,LOOPS,COLR
;+
; NAME:
;	PSEUDO
;
; PURPOSE:
;	Generate a pseudo-color table based on the LHB,
;	(lightness, hue, and brightness) system and load it.
;
; CATEGORY:
;	Z4 - Image processing, color table manipulation.
;
; CALLING SEQUENCE:
;	PSEUDO, Litlo, Lithi, Satlo, Sathi, Hue, Loops [, Colr]
;
; INPUTS:
;	Litlo:	Starting lightness, from 0 to 100%.
;
;	Lithi:	Ending lightness, from 0 to 100%.
;
;	Satlo:	Starting saturation, from 0 to 100%.
;
;	Sathi:	Ending saturation, from 0 to 100%.
;
;	Hue:	Starting hue, in degrees, from 0 to 360.
;
;	Loops:	The number of loops of hue to make in the color helix.
;		This value can range from 0 to around 3 to 5 and it need
;		not be an integer.
;
; OUTPUTS:
;	No required outputs.
;
; OPTIONAL OUTPUT PARAMETERS:
;	Colr:	A [256,3] integer array containing the red, green, and 
;		blue color values that were loaded into the color lookup 
;		tables.  Red = COLR[*,0], Green = COLR[*,1], Blue = COLR[*,1].
;
; COMMON BLOCKS:
;	None.
;
; SIDE EFFECTS:
;	Color tables are loaded.
;
; RESTRICTIONS:
;	None.
;
; PROCEDURE:
;	This procedure generates a pseudo-color table and loads the red,
;	green, and blue LUTS with the table.  The pseudo-color mapping 
;	used is generated by first translating from the LHB (lightness, 
;	hue, and brightness) coordinate system to the LAB coordinate 
;	system, finding N colors spread out along a helix that spans
;	this LAB space (supposedly a near maximal entropy mapping for 
;	the eye, given a particular N) and remapping back into the RGB
;	space (red, green, and blue color space).  Thus, given N desired 
;	colors, the output will be N discrete values loaded into the
;	red LUTs, N discrete values loaded into the blue LUTs, and N
;	discrete values loaded into the green LUTs. 
;   
; MODIFICATION HISTORY:
;	Adapted from the IIS primitive DPSEU. DMS, Nov, 1982.
;	Changed common, DMS, Apr, 1987.
;       MWR:  9/13/94 - The cur_* variables in common block need to be non-zero
;                       for use with other routines (e.g. XPALETTE).
;       MWR: 10/27/94 - Changed common block variable names to comply with
;                       naming convention used by other IDL routines.
;-   
        COMMON colors, r_orig, g_orig, b_orig, r_curr, g_curr, b_curr
	ON_ERROR,2                      ;Return to caller if an error occurs
	GAMINV=1./2.			;Gamma correction, was 1/2.7
	DTOR = .017452393		;Degs to radians
;
;		conversion matrix from x-y-z to r-g-b color coordinates
	CVT = [[2.58,-1.09,.125],[-1.15,2.04,-.295],[-.422,.058,1.17]]
;
	ZSTEP = FINDGEN(256)		;From 0 to 255.
	X = ZSTEP/(255./2.) - 1.	;From -1 to +1
	S = (SATHI-SATLO) * ( 1. -X*X) + SATLO	;Saturation
	H = (HUE + ZSTEP*(LOOPS*360./256.))*DTOR ;Hue in radians
;			Into Lab coords from Lsh.
	A = S*COS(H)
	B = S * SIN(H)
	L = (LITHI-LITLO)/255. * ZSTEP + LITLO	;Liteness
;		Cvt from LAB to XYZ coordinates.
	T = (L + 16.)/116.
	X = (A/500. + T) ^ 3		;Into X-Y-Z space from L-a-b
	Y = T^3
	Z = (T - B/200.) ^ 3
;		Cvt from XYZ to RGB.
	COLR = FIX(([[X],[Y],[Z]] # CVT > 0. < 1.) ^ GAMINV * 255.)
;               Save the colors in the common block
	r_orig = colr[*,0] & g_orig = colr[*,1] & b_orig=colr[*,2]
        r_curr = r_orig & g_curr = g_orig & b_curr = b_orig
	tvlct,r_orig,g_orig,b_orig
	RETURN
END

