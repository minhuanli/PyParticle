function autocorrelation,data
;+
; NAME:
;		autocorrelation
; PURPOSE:
;		Calculates autocorrelation function of a two-dimensional
;		data set
; CATEGORY:
;		Image Processing, Data Processing
; CALLING SEQUENCE:
;		ac = autocorrelation( data )
; INPUTS:
;		data: two-dimensional data set
; OUTPUTS:
;		ac : autocorrelation function of data
; RESTRICTIONS:
;		can be slow with large data sets
; PROCEDURE:
;		uses the convolution theorem for Fourier transforms
; MODIFICATION HISTORY:
;		written by David G. Grier AT&T Bell Laboratories 1/91
;		corrected normalization 9/91.
;		allowed for complex data 1/23/95.
;-

on_error,2

message,'Calculating Autocorrelation Function',/inf
sz = size( data )
if sz(0) ne 2 then message,'Requires 2d data set'
ac = fft( data, -1 )
ac =  ac * conj( ac )
if sz(3) ne 6 then $
	ac = float( fft( ac, 1, /overwrite ) ) $
else $
	ac = fft( ac, 1 )
ac = ac * float( sz(4) )
return, shift( ac, sz(1)/2, sz(2)/2 )
end
