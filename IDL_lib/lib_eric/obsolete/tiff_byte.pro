; $Id: //depot/idl/IDL_71/idldir/lib/obsolete/tiff_byte.pro#1 $
;
; Copyright (c) 1991-2009. ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.


function tiff_byte, a,i,len=len ;return bytes from array a(i)
common tiff_com, order, ifd, count

on_error,2              ;Return to caller if an error occurs

if n_elements(len) le 0 then len = 1
if len gt 1 then result = a[i:i+len-1] $
else result = a[i]
return, result
end
