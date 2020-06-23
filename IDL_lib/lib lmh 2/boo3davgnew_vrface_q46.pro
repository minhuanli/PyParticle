;**0;solid bond number,1:q4_coursegrain,2:q6_coursegrain,**3:w4 coursegrain,**4: w6 course grain, **5:q4,**6:q6,**7:,w4,**8:w6,**9,x,**10,y,**11:z,**12:bond number(including 12.5&13.5)
;**13:q4_coursegrain(no average),**14:q6_coursegrain(no average),15:w4_coursegrain(no average),16:w6_course_grain(no average)
function boo3davgnew_vrface_q46,tr,dc=dc,parameterq6=parameterq6
start=systime(/second)
if (not keyword_set(dc)) then dc=0.7
pos=tr(0:2,*)
n1=n_elements(pos(0,*))
bo01=fltarr(17,n1)
nn1=n_elements(tr(*,0))
parameterq6=fltarr(17,n1)
parameterq6[0:2,*]=tr[0:2,*]
parameterq6[16,*]=tr[nn1-1,*]
qqa1=complexarr(13,n1)
qqb1=complexarr(9,n1)
;wig4=fltarr(1,n1)
;wig44=fltarr(1,n1)
;wig6=fltarr(1,n1)
;wig66=fltarr(1,n1)
;wig66_noaverage=fltarr(1,n1)
;wig44_noaverage=fltarr(1,n1)
m01=[-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6]
mm01=[-4,-3,-2,-1,0,1,2,3,4]
;wig602=complexarr(13,13,13)
;wig402=complexarr(9,9,9)
;wig603=complexarr(13,13,13)
;wig403=complexarr(9,9,9)

area1=vrarea_lmh(pos,nb1=nb1)

for j=0.,n1-1 do begin
 if j mod 1000 eq 0 then print,j
 ;dx=pos(0,*)-pos(0,j)
 ;dy=pos(1,*)-pos(1,j)
 ;dz=pos(2,*)-pos(2,j)
 ;wwww=where(abs(dx) le deltar+1 and abs(dy) le deltar+1 and abs(dz) le deltar+1,nwwww)
 ;dx=dx[0,wwww]
 ;dy=dy[0,wwww]
 ;dz=dz[0,wwww]
 ;a1=(dx)^2+(dy)^2+(dz)^2
 ;aa1=sort(a1)
; ww=aa1[1:min([bondmax,nwwww-1])]
 ;aaa1=a1[ww]
 ;ddx=dx(0,ww)
; ddy=dy(0,ww)
 ;ddz=dz(0,ww)  
 ;w=where(aaa1 gt 0. and aaa1 le deltar^2,nc1)
 
 nc1=nb1(0,j)
 wwww=nb1(1:nc1,j)
 ddx=pos(0,wwww)-pos(0,j)
 ddy=pos(1,wwww)-pos(1,j)
 ddz=pos(2,wwww)-pos(2,j)
 

 bo01(12,j)=nc1
 
 
;---------------------------------------------- calculate the q6,q4-----------------------------
 if wwww[0] ne -1 then begin
  areaj=area1(1:nc1,j)
  areatj=area1(0,j)
  c1=findgen(3,nc1)
  c1(0,*)=ddx(0,*)
  c1(1,*)=ddy(0,*)
  c1(2,*)=ddz(0,*)
  sph1=cv_coord(from_rect=c1,/to_sphere); trans to sphere corrdination
  sph1(1,*)=!pi/2-sph1(1,*)
  q66=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),6,-1)))/areatj
  q65=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),6,-2)))/areatj
  q64=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),6,-3)))/areatj
  q63=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),6,-4)))/areatj
  q62=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),6,-5)))/areatj
  q61=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),6,-6)))/areatj
  q67=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),6,0)))/areatj
  q68=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),6,1)))/areatj
  q69=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),6,2)))/areatj
  q610=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),6,3)))/areatj
  q611=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),6,4)))/areatj
  q612=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),6,5)))/areatj
  q613=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),6,6)))/areatj
  q41=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),4,-4)))/areatj
  q42=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),4,-3)))/areatj
  q43=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),4,-2)))/areatj
  q44=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),4,-1)))/areatj
  q45=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),4,0)))/areatj
  q46=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),4,1)))/areatj
  q47=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),4,2)))/areatj
  q48=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),4,3)))/areatj
  q49=total(areaj(*)*(spher_harm(sph1(1,*),sph1(0,*),4,4)))/areatj
  parameterq6[3,j]=q61
  parameterq6[4,j]=q62
  parameterq6[5,j]=q63
  parameterq6[6,j]=q64
  parameterq6[7,j]=q65
  parameterq6[8,j]=q66
  parameterq6[9,j]=q67
  parameterq6[10,j]=q68
  parameterq6[11,j]=q69
  parameterq6[12,j]=q610
  parameterq6[13,j]=q611
  parameterq6[14,j]=q612
  parameterq6[15,j]=q613
  qqa1(0,j)=q61
  qqa1(1,j)=q62
  qqa1(2,j)=q63
  qqa1(3,j)=q64
  qqa1(4,j)=q65
  qqa1(5,j)=q66
  qqa1(6,j)=q67
  qqa1(7,j)=q68
  qqa1(8,j)=q69
  qqa1(9,j)=q610
  qqa1(10,j)=q611
  qqa1(11,j)=q612
  qqa1(12,j)=q613
  qqb1(0,j)=q41
  qqb1(1,j)=q42
  qqb1(2,j)=q43
  qqb1(3,j)=q44
  qqb1(4,j)=q45
  qqb1(5,j)=q46
  qqb1(6,j)=q47
  qqb1(7,j)=q48
  qqb1(8,j)=q49
  q6a=qqa1(*,j)
  q4a=qqb1(*,j)
  q4001=(4.0*!pi/9)*total((abs(q4a))^2)
  q6001=(4.0*!pi/13)*total((abs(q6a))^2)
  q4002=sqrt(q4001)
  q6002=sqrt(q6001)
  bo01(5,j)=q4002
  bo01(6,j)=q6002
 endif
;------------------------------------------------
endfor
bo01(9:11,*)=tr(0:2,*)
endtime=systime(/second)
print,'running time',endtime-start
return,bo01
end