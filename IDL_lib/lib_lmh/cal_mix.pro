
function cal_angle,v1,v2
if norm(v1-v2) le 0.00001 then begin
a=0L 
endif else begin
x1=v1(0,*)
y1=v1(1,*)
z1=v1(2,*)
x2=v2(0,*)
y2=v2(1,*)
z2=v2(2,*)
r1=sqrt(x1*x1+y1*y1+z1*z1)
r2=sqrt(x2*x2+y2*y2+z2*z2)
cs=(x1*x2+y1*y2+z1*z2)/(r1*r2)
a=acos(cs)
endelse 
return,a

end
;-------------------------------------------------------------------------------
;----------------------------------------------------------------------------
;only functional for hetero samples, (110) of BCC on xy, (111) of rhcp on xy 
function mix_misangle,latbcc=latbcc,lathcp=lathcp
pi=3.1415926
; select the densely packed layer
w=where(abs(latbcc(3,*)) lt 0.5,nw)
;print,nw
if nw ne 6 then begin
print,'bcc layer wrong'
return,[-1.]
endif

ww=where(abs(lathcp(2,*)) lt 0.5,nww)
;print,nww
if nww ne 6 then begin
print,'rhcp layer wrong'
return,[-1.]
endif

; find the mismatch angle
result=fltarr(6)
for i=0,5 do begin 
  temp=fltarr(6)
  for j=0,5 do begin
    temp(j)=cal_angle(latbcc(1:3,w(i)),lathcp(0:2,ww(j)))
  endfor
  result(i)=min(temp)
endfor
print,result
return,mean(result)*180./pi

end
;--------------------------------------------------------------------------
;--------------------------------------------------------------------------
function cal_mix,crbcc=crbcc,crhcp=crhcp,database=database,rmax=rmax

prjb=prj_voi(cpdata=crbcc,data=database,dr=rmax,nmax=14)
prjh=prj_voi(cpdata=crhcp,data=database,dr=rmax,nmax=12)

latb=latt_bcc(prj=prjb,dc=0.15,ampli=3.)
lath=latt_rhcp(prj=prjh,dc=0.15,ampli=3.)

wj1=where(latb(0,*) eq 6, nwj1)
if nwj1 ne 6 then begin
    print,'wrong with bcc type crystal'
    return,[-1.]
endif

result=mix_misangle(latbcc=latb,lathcp=lath)

return,result

end














