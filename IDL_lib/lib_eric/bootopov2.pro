pro bootopov2,data,fname,r1=r1,c1=c1,c2=c2,c3=c3,camera=camera,noclip=noclip
tm=max(data(15,*))
tmin=min(data(15,*))
ta=tmin+indgen(tm-tmin+1)
tb=string(byte(tmin)+indgen(tm-tmin+1))
f01=fname+tb+'.pov'
a22=eclip(data,[0,25,75],[1,25,75],[2,25,75])
if (keyword_set(noclip)) then a22=data
for j=0,tm-tmin do begin
w=where(a22(15,*) eq ta[j])
a2=a22(*,w)
n1=n_elements(a2(0,*))
ra=fltarr(1,n1)
ca=fltarr(3,n1)
w1=where(a2(5,*) ge 0.27 and a2(14,*) gt 13,na)
if na gt 0 then begin
if keyword_set(r1) then begin
ra(0,w1)=r1[0]
endif else begin
ra(0,w1)=1.85
endelse
if (keyword_set(color1)) then begin
ca(0,w1)=c1[0]
ca(1,w1)=c1[1]
ca(2,w1)=c1[2]
endif else begin
ca(0,w1)=205
ca(1,w1)=0
ca(2,w1)=0
endelse
endif
;w11=where(a2(3,*) ge 7.0 and a2(14,*) lt 13,na)
;if na gt 0 then begin
;if keyword_set(r1) then begin
;ra(0,w11)=r1[0]
;endif else begin
;ra(0,w11)=1.85
;endelse
;if (keyword_set(color1)) then begin
;ca(0,w11)=c1[0]
;ca(1,w11)=c1[1]
;ca(2,w11)=c1[2]
;endif else begin
;ca(0,w11)=139
;ca(1,w11)=0
;ca(2,w11)=139
;endelse
;endif
w2=where(a2(5,*) ge 0.27 and a2(14,*) lt 13,na)
if na gt 0 then begin
b002=a2(*,w2)
b0x=b002(8,*)-0.1
b0y=b002(10,*)+0.2
b0z=b0y/b0x
w13=where(b0x gt 0 and b0z lt 0.4/0.15,nc)
if nc gt 0 then begin
if keyword_set(r1) then begin
ra(0,w2)=r1[1]
ra(0,w2[w13])=r1[1]
endif else begin
ra(0,w2)=1.85
ra(0,w2[w13])=1.85
endelse
if (keyword_set(c2)) then begin
ca(0,w2)=c2[0]
ca(1,w2)=c2[1]
ca(2,w2)=c2[2]
ca(0,w2[w13])=c2[0]
ca(1,w2[w13])=c2[1]
ca(2,w2[w13])=c2[2]
endif else begin
ca(0,w2)=160
ca(1,w2)=32
ca(2,w2)=240
ca(0,w2[w13])=0
ca(1,w2[w13])=139
ca(2,w2[w13])=139
endelse
endif
endif
;w22=where(a2(3,*) lt 7.0 and a2(5,*) gt 0.27 and a2(14,*) lt 13,na)
;if na gt 0 then begin
;if keyword_set(r1) then begin
;ra(0,w22)=r1[1]
;endif else begin
;ra(0,w22)=1.85
;endelse
;if (keyword_set(c2)) then begin
;ca(0,w22)=c2[0]
;ca(1,w22)=c2[1]
;ca(2,w22)=c2[2]
;endif else begin
;ca(0,w22)=255
;ca(1,w22)=0
;ca(2,w22)=255
;endelse
;endif
w3=where(a2(5,*) lt 0.27,na)
if na gt 0 then begin
if keyword_set(r1) then begin
ra(0,w3)=r1[0]
endif else begin
ra(0,w3)=0.2
endelse
if (keyword_set(c3)) then begin
ca(0,w3)=c3[0]
ca(1,w3)=c3[1]
ca(2,w3)=c3[2]
endif else begin
ca(0,w3)=0
ca(1,w3)=0
ca(2,w3)=139
endelse
endif
ca=ca/255.0
if (keyword_set(camera)) then begin
mkpov,a2(0:2,*),radius=ra,color=ca,margin=2,f01[j],camera=camera,/light
endif else begin
mkpov,a2(0:2,*),radius=ra,color=ca,margin=2,f01[j]
endelse
endfor
end



