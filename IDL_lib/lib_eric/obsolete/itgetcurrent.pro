; $Id: //depot/idl/IDL_71/idldir/lib/obsolete/itgetcurrent.pro#1 $
; Copyright (c) 2002-2009, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.
;+
; NAME:
;   itGetCurrent
;
; PURPOSE:
;   Returns the current tool in the system.
;
; CALLING SEQUENCE:
;   idTool = itGetCurrent()
;
; INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   TOOL: Set this keyword to a named variable in which to return the
;       object reference to the current tool object.
;       If there is no current tool then a null object is returned.
;
;   THUMBNAIL : If set to a named variable, and a current tool exists, this 
;               will return a thumbnail image of the current tool.  The image 
;               is returned as a true colour (3xMxM) image.
;
;   THUMBSIZE : The size of the thumbnail to return.  The thumbnail is always
;               returned as a square image.  If not supplied a default value
;               of 32 is used.  THUMBSIZE must be greather than 3 and must 
;               shrink the tool window.  This keyword is ignored if THUMBNAIL 
;               is not used.
;
;   THUMBORDER : Set this keyword to return the thumbnail in top-to-bottom order
;            rather than the IDL default of bottom-to-top order.
;
;   THUMBBACKGROUND : The colour of the excess background to use in the 
;                     thumbnail.  This only has effect if the aspect ratio of
;                     the tool window is not equal to 1.  If set to a scalar
;                     value the colour of the lower left pixel of the window
;                     is used as the background colour.  If set to an RGB
;                     triplet the supplied colour will be used.  If not
;                     specified a value of [255,255,255] (white) is used.  This
;                     keyword is ignored if THUMBNAIL is not used.
;
; RETURN VALUE
;   An identifier for the current tool. If no tool is current,
;   an empty ('') string is returned.
;
; MODIFICATION HISTORY:
;   Written by:  KDB, RSI, Novemember 2002
;   Modified: CT, RSI, Jan 2004: Added TOOL keyword.
;   Modified: AGEH, RSI, Jun 2008: Added THUMB* keywords.
;
;-

;-------------------------------------------------------------------------
FUNCTION itGetCurrent, TOOL=oTool, $
                       THUMBNAIL=thumb, $
                       THUMBORDER=tOrder, $
                       THUMBSIZE=tSizeIn, $
                       THUMBBACKGROUND=tColourIn

   compile_opt hidden, idl2

   return, iGetCurrent(TOOL=oTool, $
                       THUMBNAIL=thumb, $
                       THUMBORDER=tOrder, $
                       THUMBSIZE=tSizeIn, $
                       THUMBBACKGROUND=tColourIn)

end


