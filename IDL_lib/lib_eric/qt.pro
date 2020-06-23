
function qt, xyt, a, mydts=mydts

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

aa=a^2

for ti=0,ndt-1 do begin
	print,ti
	delt=dt[ti]
	;print, delt
	;q[0,ti]=delt
	qchi[0,ti]=delt
	qt=fltarr(1,tmax-delt)
	for t1=0,tmax-delt-1 do begin
		t2=t1+delt
		if (t2 le tmax) then begin
			ptcli=where(tt eq t1, counti)
			ptclj=where(tt eq t2, countj)
			;for i=0,counti-1 do begin
			;	xi=xyt[0, ptcli[i]]
			;	yi=xyt[1, ptcli[i]]
			;	;ptclj=where(tt eq t2, countj)
			;	for j=0,countj-1 do begin
			;		xj=xyt[0, ptclj[j]]
			;		yj=xyt[1, ptclj[j]]
			;		xij=xi-xj
			;		yij=yi-yj
			;		if ( xij*xij+yij*yij le aa ) then qt[t1]=qt[t1]+1
			;		; aa=a*a
			;	endfor
			;endfor
			;
			; modified on Sep 16, 2010
			;xyij=fltarr(counti,countj,2)
			;for i=0, countj-1 do begin
			;	xyij[i, *, 0]=xyt[0, ptcli]	;x
			;	xyij[i, *, 1]=xyt[1, ptcli]	;y
			;endfor
			;for j=0, counti-1 do begin
			;	xyij[*, j, 0]=xyij[*, j, 0]-xyt[0, ptclj]
			;	xyij[*, j, 1]=xyij[*, j, 1]-xyt[1, ptclj]
			;endfor
			;xy=xyij[*, *, 0]*xyij[*, *, 0] + xyij[*,*,1]*xyij[*,*,1]
			;p=where(xy le aa, count)
			;qt[t1]=count
			; modification end
			;
			; modified to speed more, but the basic idea is same as above
			xi=xyt[0, ptcli]
			yi=xyt[1, ptcli]
			xj=xyt[0, ptclj]
			yj=xyt[1, ptclj]
			xii=xi
			yii=yi
			for i=1, countj-1 do begin
				xii=[xii, xi]
				yii=[yii, yi]
			endfor
			xjj=xj
			yjj=yj
			for j=1, counti-1 do begin
				xjj=[xjj, xj]
				yjj=[yjj, yj]
			endfor
			xij=xii-transpose(xjj)
			yij=yii-transpose(yjj)
			xy=xij*xij+yij*yij
			p=where(xy le aa, count)
			qt[t1]=count
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
