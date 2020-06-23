function checkquadrant,pos0,xref,yref,hix=hix,hiy=hiy, $
      nr,rvec,rsqr,rmax,thetax=thetax,thetay=thetay
;
; this function calculates the angle (in radians) of the arc
;     that falls within this quadrant; used later for
;     normalization
;
; Clearly, this subroutine is the slowest part of the program.
; I think it's optimized but worth double-checking.  Could
; possibly speed up the acos calls with a lookup table?
;
; pos0 is the test-point
; xref & yref are the edges that may be closest
; /hix and /hiy indicate the high-value edges x1 & y1 rather
;     than the low-value edges x0 & y0
; nr,rvec,rsqr,rmax all same as regular program
; thetax & thetay are used to pass variables which will be
;     used for other quadrants and thus save time
;     recalculating them


rvec2=rvec > 0.001; ---> to avoid divide-by-zero errors

if (not keyword_set(thetax)) then begin
  if (keyword_set(hix)) then begin
    if ((xref-rmax) gt pos0(0)) then begin
      thetax=fltarr(nr);    --> zero!
    endif else begin
      xprime=(abs(fltarr(nr)+xref-pos0(0))) < rvec
      thetax=acos(xprime/rvec2)
    endelse
  endif else begin
    if ((xref+rmax) lt pos0(0)) then begin
      thetax=fltarr(nr);    --> zero!
    endif else begin
      xprime=abs(fltarr(nr)+pos0(0)-xref) < rvec
      thetax=acos(xprime/rvec2)
    endelse
  endelse
endif

if (not keyword_set(thetay)) then begin
  if (keyword_set(hiy)) then begin
    if ((yref-rmax) gt pos0(1)) then begin
      thetay=fltarr(nr);    --> zero!
    endif else begin
      yprime=abs(fltarr(nr)+yref-pos0(1)) < rvec
      thetay=acos(yprime/rvec2)
    endelse
  endif else begin
    if (yref+rmax lt pos0(1)) then begin
      thetay=fltarr(nr);    --> zero!
    endif else begin
      yprime=abs(fltarr(nr)+pos0(1)-yref) < rvec
      thetay=acos(yprime/rvec2)
    endelse
  endelse
endif

theta=(fltarr(nr)+3.14159265*0.5)-thetax-thetay
dcorner=pos0-[xref,yref]
cornerdist=total(dcorner*dcorner)
w=where(rsqr ge cornerdist,nw)
if (nw gt 0) then theta(w)=0.0
return,theta
end