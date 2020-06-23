function g61,points,border,p6=p6,normalize=normalize,radial=radial

x = reform(points(0,*))
y = reform(points(1,*))
p6 = psi6(points)
p06=abs(p6)
w=where(p06 gt mean(p06))
p6=p6[w]
roi = where(x gt border(0) and x lt border(1) and $
  y gt border(2) and y lt border(3) )
p6 = p6(roi)
points = points(*,roi)


data = points2image(points,p6,/exact)
data = autocorrelation(data)

area = float(n_elements(data))
npts = float(n_elements(points(0,*)))

if keyword_set( normalize ) then begin  ; Normalize for distribution of points
  d2 = points2image( points, /exact )
  d2 = gr( d2 )
  data = data / d2
  endif

if keyword_set( radial ) then $
  data = aziavg( data )

data = data * area * npts^(-2)    ; normalization for density of points
return,data
end

