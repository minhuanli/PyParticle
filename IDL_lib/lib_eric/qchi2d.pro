;calculation dynamic hetero genity in 2d 
function qchi2d, xyt, a, mydts=mydts

; xyt: (3, npts*nframe) (x,y,t)


tt=xyt[5,*] ; time
tmax=max(tt) ; maximum time
tl=n_elements(tt) ; time length
;print, tt

if not keyword_set(mydts) then begin
; generate the time partition-- about 10 points per decade
  dt = round(1.15^findgen(150))
  dt = dt(uniq(dt))
  dt=[0,dt]
  w = where( dt le tmax, ndt )
  if ndt gt 0 then dt = dt(w) else message,'Invalid maximum dt!'
endif else begin
  dt = mydts
  ndt = n_elements(dt)
endelse
;print, dt
      width=fix((max(xyt(0,*)) + 1)/a)
      hight=fix((max(xyt(1,*)) + 1)/a)
      w1=fix(max(xyt(0,*))) + 1
      h1=fix(max(xyt(1,*))) + 1
qchi=fltarr(width,hight,ndt) ; time: q
;chi=fltarr(2,ndt) ; time: chi


     

for ti=0,ndt-1 do begin
  ;print,ti
  delt=dt[ti]
  print, delt
  ;q[0,ti]=delt
  ;qchi[0,ti]=delt
  qt=fltarr(width,hight,tmax-delt)
     
  for t1=0,tmax-delt-1 do begin
    t2=t1+delt
    if (t2 le tmax) then begin
      wptcli=where(tt eq t1, counti)
      wptclj=where(tt eq t2, countj)
      ptcli=xyt(*,wptcli)
      ptclj=xyt(*,wptclj)
      
      
      

      imgi=points2image(ptcli(0:1,*),w=w1,h=h1)
      imgj=points2image(ptclj(0:1,*),w=w1,h=h1)
      wth=width*a-1
      hit=hight*a-1
      imgi=rebin(imgi(0:wth,0:hit),width,hight)
      imgj=rebin(imgj(0:wth,0:hit),width,hight)
      imgij=imgi*imgj
      wa=where(imgij ne 0)
      imgij(wa)=1.0
      qt(*,*,t1)=imgij
      
      
     
     endif
  endfor
  
  l=n_elements(qt)
  qchi[*,*,ti]=rebin(qt,width,hight,1)

endfor

return, qchi
end
