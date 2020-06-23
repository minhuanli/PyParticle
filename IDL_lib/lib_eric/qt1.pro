;calculation dynamic hetero genity in 2d 
function qt1, xyt, a, mydts=mydts

; xyt: (3, npts*nframe) (x,y,t)
; 
; version 2
; modified by Feng Wang @ HKUST
; Sep 16, 2010
;
; 1, try to use matrix operation instead of element manipulation to speed up the code.

tt=xyt[5,*] ; time
tmax=max(tt) ; maximum time
tl=n_elements(tt) ; time length
;print, tt

if not keyword_set(mydts) then begin
; generate the time partition-- about 10 points per decade
	dt = round(1.15^findgen(150))
	dt = dt(uniq(dt))
	w = where( dt le tmax, ndt )
	if ndt gt 0 then dt = dt(w) else message,'Invalid maximum dt!'
endif else begin
	dt = mydts
	ndt = n_elements(dt)
endelse
;print, dt

qchi=fltarr(3,ndt) ; time: q
;chi=fltarr(2,ndt) ; time: chi

aa=a*a

for ti=0,ndt-1 do begin
	;print,ti
	delt=dt[ti]
	print, delt
	;q[0,ti]=delt
	qchi[0,ti]=delt
	qt=fltarr(1,tmax-delt)
	for t1=0,tmax-delt-1 do begin
		t2=t1+delt
		if (t2 le tmax) then begin
			ptcli=where(tt eq t1, counti)
			ptclj=where(tt eq t2, countj)
			
			; An good idea occurred me on Nov 27, 2010, which I can speed up
			; the program effiently.

			; I deleted all old modification here, which can be found in 
			; qt_old.pro

			; The new idea is that overlaped particles are only in the region
			; [xi-a,xi+a]x[yi-a,yi+a]


			xi=xyt[0, ptcli]
			yi=xyt[1, ptcli]
			xj=xyt[0, ptclj]
			yj=xyt[1, ptclj]
			qt[t1]=0
			for i=0,counti-1 do begin
				j=where((xj ge xi[i]-a) and (xj le xi[i]+a) and (yj ge yi[i]-a) and (yj le yi[i]+a), ct)
				if ct gt 0 then begin
					xjj=xj[j]-xi[i]
					yjj=yj[j]-yi[i]
					xy=xjj*xjj+yjj*yjj
					k=where(xy le aa, count)
					qt[t1]=qt[t1]+count
				endif
			endfor
			; modification end
			;endfor
		endif
	endfor
	l=n_elements(qt)
	qchi[1,ti]=mean(qt)
	qchi[2,ti]=variance(qt)*(l-1.0)/l
	; variance in idl is different with <(Q-<Q>)^2>.

endfor
return, qchi
end
