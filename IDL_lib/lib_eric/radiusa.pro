function radiusa,tr,dr=dr
n1=n_elements(tr(0,*))
tr1=fltarr(7,n1)
tr1(0:2,*)=tr(0:2,*)
pos=tr(0:2,*)
for j=0.,n1-1 do begin
;print,j
dx=pos(0,*)-pos(0,j)
dy=pos(1,*)-pos(1,j)
dz=pos(2,*)-pos(2,j)
a1=(dx)^2+(dy)^2+(dz)^2
w2=where(a1 lt 1.0*dr*dr,nc1)
w1=where(a1 lt 1000.0,nv)
a1=a1[0,w1]
aa1=sort(a1)
if nv gt 14 then begin
;ww=aa1[1:bondmax]
aaa1=sqrt(a1[aa1[12]])
aaa2=sqrt(a1[aa1[13]])
aaa3=sqrt(a1[aa1[14]])
tr1(3,j)=aaa1
tr1(4,j)=aaa2
tr1(5,j)=aaa3
endif
tr1(6,j)=nc1
endfor
return,tr1
end

;ddx=dx(0,ww)
;ddy=dy(0,ww)
;ddz=dz(0,ww)
;w=where(aaa1 gt 0. and aaa1 le deltar^2)
;b1=n_elements(w)
;bo01(12,j)=b1
;if w[0] ne -1 then begin
;c1=findgen(3,b1)
;c1(0,*)=ddx(0,w)
;c1(1,*)=ddy(0,w)
;c1(2,*)=ddz(0,w)
