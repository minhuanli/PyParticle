;0;solid bond number,1:q4_coursegrain,2:q6_coursegrain,3:w4 coursegrain,4: w6 course grain, 5:q4,6:q6,7:,w4,8:w6,9,x,10,y,11,z
function boo3davggadc,tr,deltar=deltar,bondmax=bondmax
pos=tr(0:2,*)
n1=n_elements(pos(0,*))
bo01=fltarr(13,n1)
qqa1=complexarr(13,n1)
qqb1=complexarr(9,n1)
wig4=fltarr(1,n1)
wig44=fltarr(1,n1)
wig6=fltarr(1,n1)
wig66=fltarr(1,n1)
m01=[-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6]
mm01=[-4,-3,-2,-1,0,1,2,3,4]
wig602=complexarr(13,13,13)
wig402=complexarr(9,9,9)
wig603=complexarr(13,13,13)
wig403=complexarr(9,9,9)
for j=0.,n1-1 do begin
;print,j
dx=pos(0,*)-pos(0,j)
dy=pos(1,*)-pos(1,j)
dz=pos(2,*)-pos(2,j)
a1=(dx)^2+(dy)^2+(dz)^2
aa1=sort(a1)
ww=aa1[1:bondmax]
aaa1=a1[ww]
ddx=dx(0,ww)
ddy=dy(0,ww)
ddz=dz(0,ww)
w=where(aaa1 gt 0. and aaa1 le deltar^2,nc1)

bo01(12,j)=nc1
if nc1 eq 13.0 then begin
if sqrt(aaa1[12])+sqrt(aaa1[13]) le 2.0*deltar then begin
w=[0,1,2,3,4,5,6,7,8,9,10,11,12,13]
bo01(12,j)=13.5
endif
if sqrt(aaa1[12])+sqrt(aaa1[13]) gt 2.0*deltar then begin
w=[0,1,2,3,4,5,6,7,8,9,10,11]
bo01(12,j)=12.5
endif
endif
b1=n_elements(w)

if w[0] ne -1 then begin
c1=findgen(3,b1)
c1(0,*)=ddx(0,w)
c1(1,*)=ddy(0,w)
c1(2,*)=ddz(0,w)
sph1=cv_coord(from_rect=c1,/to_sphere)
sph1(1,*)=!pi/2-sph1(1,*)
q66=mean(spher_harm(sph1(1,*),sph1(0,*),6,-1))
q65=mean(spher_harm(sph1(1,*),sph1(0,*),6,-2))
q64=mean(spher_harm(sph1(1,*),sph1(0,*),6,-3))
q63=mean(spher_harm(sph1(1,*),sph1(0,*),6,-4))
q62=mean(spher_harm(sph1(1,*),sph1(0,*),6,-5))
q61=mean(spher_harm(sph1(1,*),sph1(0,*),6,-6))
q67=mean(spher_harm(sph1(1,*),sph1(0,*),6,0))
q68=mean(spher_harm(sph1(1,*),sph1(0,*),6,1))
q69=mean(spher_harm(sph1(1,*),sph1(0,*),6,2))
q610=mean(spher_harm(sph1(1,*),sph1(0,*),6,3))
q611=mean(spher_harm(sph1(1,*),sph1(0,*),6,4))
q612=mean(spher_harm(sph1(1,*),sph1(0,*),6,5))
q613=mean(spher_harm(sph1(1,*),sph1(0,*),6,6))
q41=mean(spher_harm(sph1(1,*),sph1(0,*),4,-4))
q42=mean(spher_harm(sph1(1,*),sph1(0,*),4,-3))
q43=mean(spher_harm(sph1(1,*),sph1(0,*),4,-2))
q44=mean(spher_harm(sph1(1,*),sph1(0,*),4,-1))
q45=mean(spher_harm(sph1(1,*),sph1(0,*),4,0))
q46=mean(spher_harm(sph1(1,*),sph1(0,*),4,1))
q47=mean(spher_harm(sph1(1,*),sph1(0,*),4,2))
q48=mean(spher_harm(sph1(1,*),sph1(0,*),4,3))
q49=mean(spher_harm(sph1(1,*),sph1(0,*),4,4))
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
endif
endfor
for i=0.,n1-1 do begin
;print,i
dx1=pos(0,*)-pos(0,i)
dy1=pos(1,*)-pos(1,i)
dz1=pos(2,*)-pos(2,i)
a2=(dx1)^2+(dy1)^2+(dz1)^2
a2a=sort(a2)
w11=a2a[1:bondmax]
a3=a2(0,w11)
w12=where(a3 gt 0. and a3 le deltar^2)
if w12[0] ne -1 then begin
w1=w11[w12]
;w1=where(a2 gt 0. and a2 le deltar^2)
;if w1[0] ne -1 then begin
qlm1=sqrt(total((abs(qqa1(*,i)))^2))
qlmw=sqrt(total((abs(qqa1(*,w1)))^2,1))
;qiqj01=abs(qqa1(0,i)*(qqa1(0,w1)))+abs(qqa1(1,i)*(qqa1(1,w1)))+abs(qqa1(2,i)*(qqa1(2,w1)))+abs(qqa1(3,i)*(qqa1(3,w1)))+abs(qqa1(4,i)*(qqa1(4,w1)))+abs(qqa1(5,i)*(qqa1(5,w1)))+abs(qqa1(6,i)*(qqa1(6,w1)))+abs(qqa1(7,i)*(qqa1(7,w1)))+abs(qqa1(8,i)*(qqa1(8,w1)))+abs(qqa1(9,i)*(qqa1(9,w1)))+abs(qqa1(10,i)*(qqa1(10,w1)))+abs(qqa1(11,i)*(qqa1(11,w1)))+abs(qqa1(12,i)*(qqa1(12,w1)))
;qiqj02=abs(qiqj01)/(qlm1*qlmw)
;qiqj01=qqa1(0,i)*conj(qqa1(0,w1))+qqa1(1,i)*conj(qqa1(1,w1))+qqa1(2,i)*conj(qqa1(2,w1))+qqa1(3,i)*conj(qqa1(3,w1))+qqa1(4,i)*conj(qqa1(4,w1))+qqa1(5,i)*conj(qqa1(5,w1))+qqa1(6,i)*conj(qqa1(6,w1))+qqa1(7,i)*conj(qqa1(7,w1))+qqa1(8,i)*conj(qqa1(8,w1))+qqa1(9,i)*conj(qqa1(9,w1))+qqa1(10,i)*conj(qqa1(10,w1))+qqa1(11,i)*conj(qqa1(11,w1))+qqa1(12,i)*conj(qqa1(12,w1))
qiqj01=(qqa1(0,i)*conj(qqa1(0,w1)))+(qqa1(1,i)*conj(qqa1(1,w1)))+(qqa1(2,i)*conj(qqa1(2,w1)))+(qqa1(3,i)*conj(qqa1(3,w1)))+(qqa1(4,i)*conj(qqa1(4,w1)))+(qqa1(5,i)*conj(qqa1(5,w1)))+(qqa1(6,i)*conj(qqa1(6,w1)))+(qqa1(7,i)*conj(qqa1(7,w1)))+(qqa1(8,i)*conj(qqa1(8,w1)))+(qqa1(9,i)*conj(qqa1(9,w1)))+(qqa1(10,i)*conj(qqa1(10,w1)))+(qqa1(11,i)*(qqa1(11,w1)))+(qqa1(12,i)*conj(qqa1(12,w1)))
qiqj02=real_part(qiqj01)/(qlm1*qlmw)
wa=where(qiqj02(0,*) gt 0.90,ncountj)
wb=where(qiqj02(0,*) le 0.90,ncountjj)
;wa=where(qiqj02(0,*) gt 0.5,ncountj)
;wb=where(qiqj02(0,*) le 0.5,ncountjj)
bo01(0,i)=ncountj
if ncountj ge 7.0 then begin
qqc1=qqa1(0,w1)
qqcc1=(total(qqc1(0,wa))+qqa1(0,i))/(1.0+ncountj)
qqc2=qqa1(1,w1)
qqcc2=(total(qqc2(0,wa))+qqa1(1,i))/(1.0+ncountj)
qqc3=qqa1(2,w1)
qqcc3=(total(qqc3(0,wa))+qqa1(2,i))/(1.0+ncountj)
qqc4=qqa1(3,w1)
qqcc4=(total(qqc4(0,wa))+qqa1(3,i))/(1.0+ncountj)
qqc5=qqa1(4,w1)
qqcc5=(total(qqc5(0,wa))+qqa1(4,i))/(1.0+ncountj)
qqc6=qqa1(5,w1)
qqcc6=(total(qqc6(0,wa))+qqa1(5,i))/(1.0+ncountj)
qqc7=qqa1(6,w1)
qqcc7=(total(qqc7(0,wa))+qqa1(6,i))/(1.0+ncountj)
qqc8=qqa1(7,w1)
qqcc8=(total(qqc8(0,wa))+qqa1(7,i))/(1.0+ncountj)
qqc9=qqa1(8,w1)
qqcc9=(total(qqc9(0,wa))+qqa1(8,i))/(1.0+ncountj)
qqc10=qqa1(9,w1)
qqcc10=(total(qqc10(0,wa))+qqa1(9,i))/(1.0+ncountj)
qqc11=qqa1(10,w1)
qqcc11=(total(qqc11(0,wa))+qqa1(10,i))/(1.0+ncountj)
qqc12=qqa1(11,w1)
qqcc12=(total(qqc12(0,wa))+qqa1(11,i))/(1.0+ncountj)
qqc13=qqa1(12,w1)
qqcc13=(total(qqc13(0,wa))+qqa1(12,i))/(1.0+ncountj)
qqd1=qqb1(0,w1)
qqdd1=(total(qqd1(0,wa))+qqb1(0,i))/(1.0+ncountj)
qqd2=qqb1(1,w1)
qqdd2=(total(qqd2(0,wa))+qqb1(1,i))/(1.0+ncountj)
qqd3=qqb1(2,w1)
qqdd3=(total(qqd3(0,wa))+qqb1(2,i))/(1.0+ncountj)
qqd4=qqb1(3,w1)
qqdd4=(total(qqd4(0,wa))+qqb1(3,i))/(1.0+ncountj)
qqd5=qqb1(4,w1)
qqdd5=(total(qqd5(0,wa))+qqb1(4,i))/(1.0+ncountj)
qqd6=qqb1(5,w1)
qqdd6=(total(qqd6(0,wa))+qqb1(5,i))/(1.0+ncountj)
qqd7=qqb1(6,w1)
qqdd7=(total(qqd7(0,wa))+qqb1(6,i))/(1.0+ncountj)
qqd8=qqb1(7,w1)
qqdd8=(total(qqd8(0,wa))+qqb1(7,i))/(1.0+ncountj)
qqd9=qqb1(8,w1)
qqdd9=(total(qqd9(0,wa))+qqb1(8,i))/(1.0+ncountj)
qq6a=[qqcc1,qqcc2,qqcc3,qqcc4,qqcc5,qqcc6,qqcc7,qqcc8,qqcc9,qqcc10,qqcc11,qqcc12,qqcc13]
qq4a=[qqdd1,qqdd2,qqdd3,qqdd4,qqdd5,qqdd6,qqdd7,qqdd8,qqdd9]
q6a=qqa1(*,i)
q4a=qqb1(*,i)
q401=(4.0*!pi/9)*((abs(qqdd1))^2+(abs(qqdd2))^2+(abs(qqdd3))^2+(abs(qqdd4))^2+(abs(qqdd5))^2+(abs(qqdd6))^2+(abs(qqdd7))^2+(abs(qqdd8))^2+(abs(qqdd9))^2)
q601=(4.0*!pi/13)*((abs(qqcc1))^2+(abs(qqcc2))^2+(abs(qqcc3))^2+(abs(qqcc4))^2+(abs(qqcc5))^2+(abs(qqcc6))^2+(abs(qqcc7))^2+(abs(qqcc8))^2+(abs(qqcc9))^2+(abs(qqcc10))^2+(abs(qqcc11))^2+(abs(qqcc12))^2+(abs(qqcc13))^2)
q4001=(4.0*!pi/9)*total((abs(q4a))^2)
q6001=(4.0*!pi/13)*total((abs(q6a))^2)
q402=sqrt(q401)
q602=sqrt(q601)
q4002=sqrt(q4001)
q6002=sqrt(q6001)
bo01(1,i)=q402
bo01(2,i)=q602
bo01(5,i)=q4002
bo01(6,i)=q6002
for l=0,12 do begin
for m=0,12 do begin
for n=0,12 do begin
if m01[l]+m01[m]+m01[n] eq 0 then begin
wig601=wigner_threej(6,6,6,m01[l],m01[m],m01[n])
wig602(l,m,n)=wig601*qq6a[l]*qq6a[m]*qq6a[n]
wig603(l,m,n)=wig601*q6a[l]*q6a[m]*q6a[n]
endif
endfor
endfor
endfor
for l=0,8 do begin
for m=0,8 do begin
for n=0,8 do begin
if mm01[l]+mm01[m]+mm01[n] eq 0 then begin
wig401=wigner_threej(4,4,4,mm01[l],mm01[m],mm01[n])
wig402(l,m,n)=wig401*qq4a[l]*qq4a[m]*qq4a[n]
wig403(l,m,n)=wig401*q4a[l]*q4a[m]*q4a[n]
endif
endfor
endfor
endfor
wig66(0,i)=real_part(total(wig602))
ym6=(total((abs(qq6a))^2))^1.5
wig66(0,i)=wig66(0,i)/ym6
wig6(0,i)=real_part(total(wig603))
ym61=(total((abs(q6a))^2))^1.5
wig6(0,i)=wig6(0,i)/ym61
wig44(0,i)=real_part(total(wig402))
ym4=(total((abs(qq4a))^2))^1.5
wig44(0,i)=wig44(0,i)/ym4
wig4(0,i)=real_part(total(wig403))
ym41=(total((abs(q4a))^2))^1.5
wig4(0,i)=wig4(0,i)/ym41
endif
if ncountj gt 0 and ncountj lt 7.0 and wb[0] eq -1 then begin
qqc1=qqa1(0,w1)
qqcc1=(total(qqc1(0,wa))+qqa1(0,i))/(1.0+ncountj)
qqc2=qqa1(1,w1)
qqcc2=(total(qqc2(0,wa))+qqa1(1,i))/(1.0+ncountj)
qqc3=qqa1(2,w1)
qqcc3=(total(qqc3(0,wa))+qqa1(2,i))/(1.0+ncountj)
qqc4=qqa1(3,w1)
qqcc4=(total(qqc4(0,wa))+qqa1(3,i))/(1.0+ncountj)
qqc5=qqa1(4,w1)
qqcc5=(total(qqc5(0,wa))+qqa1(4,i))/(1.0+ncountj)
qqc6=qqa1(5,w1)
qqcc6=(total(qqc6(0,wa))+qqa1(5,i))/(1.0+ncountj)
qqc7=qqa1(6,w1)
qqcc7=(total(qqc7(0,wa))+qqa1(6,i))/(1.0+ncountj)
qqc8=qqa1(7,w1)
qqcc8=(total(qqc8(0,wa))+qqa1(7,i))/(1.0+ncountj)
qqc9=qqa1(8,w1)
qqcc9=(total(qqc9(0,wa))+qqa1(8,i))/(1.0+ncountj)
qqc10=qqa1(9,w1)
qqcc10=(total(qqc10(0,wa))+qqa1(9,i))/(1.0+ncountj)
qqc11=qqa1(10,w1)
qqcc11=(total(qqc11(0,wa))+qqa1(10,i))/(1.0+ncountj)
qqc12=qqa1(11,w1)
qqcc12=(total(qqc12(0,wa))+qqa1(11,i))/(1.0+ncountj)
qqc13=qqa1(12,w1)
qqcc13=(total(qqc13(0,wa))+qqa1(12,i))/(1.0+ncountj)
qqd1=qqb1(0,w1)
qqdd1=(total(qqd1(0,wa))+qqb1(0,i))/(1.0+ncountj)
qqd2=qqb1(1,w1)
qqdd2=(total(qqd2(0,wa))+qqb1(1,i))/(1.0+ncountj)
qqd3=qqb1(2,w1)
qqdd3=(total(qqd3(0,wa))+qqb1(2,i))/(1.0+ncountj)
qqd4=qqb1(3,w1)
qqdd4=(total(qqd4(0,wa))+qqb1(3,i))/(1.0+ncountj)
qqd5=qqb1(4,w1)
qqdd5=(total(qqd5(0,wa))+qqb1(4,i))/(1.0+ncountj)
qqd6=qqb1(5,w1)
qqdd6=(total(qqd6(0,wa))+qqb1(5,i))/(1.0+ncountj)
qqd7=qqb1(6,w1)
qqdd7=(total(qqd7(0,wa))+qqb1(6,i))/(1.0+ncountj)
qqd8=qqb1(7,w1)
qqdd8=(total(qqd8(0,wa))+qqb1(7,i))/(1.0+ncountj)
qqd9=qqb1(8,w1)
qqdd9=(total(qqd9(0,wa))+qqb1(8,i))/(1.0+ncountj)
qq6a=[qqcc1,qqcc2,qqcc3,qqcc4,qqcc5,qqcc6,qqcc7,qqcc8,qqcc9,qqcc10,qqcc11,qqcc12,qqcc13]
qq4a=[qqdd1,qqdd2,qqdd3,qqdd4,qqdd5,qqdd6,qqdd7,qqdd8,qqdd9]
q6a=qqa1(*,i)
q4a=qqb1(*,i)
q401=(4.0*!pi/9)*((abs(qqdd1))^2+(abs(qqdd2))^2+(abs(qqdd3))^2+(abs(qqdd4))^2+(abs(qqdd5))^2+(abs(qqdd6))^2+(abs(qqdd7))^2+(abs(qqdd8))^2+(abs(qqdd9))^2)
q601=(4.0*!pi/13)*((abs(qqcc1))^2+(abs(qqcc2))^2+(abs(qqcc3))^2+(abs(qqcc4))^2+(abs(qqcc5))^2+(abs(qqcc6))^2+(abs(qqcc7))^2+(abs(qqcc8))^2+(abs(qqcc9))^2+(abs(qqcc10))^2+(abs(qqcc11))^2+(abs(qqcc12))^2+(abs(qqcc13))^2)
q4001=(4.0*!pi/9)*total((abs(q4a))^2)
q6001=(4.0*!pi/13)*total((abs(q6a))^2)
q402=sqrt(q401)
q602=sqrt(q601)
q4002=sqrt(q4001)
q6002=sqrt(q6001)
bo01(1,i)=q402
bo01(2,i)=q602
bo01(5,i)=q4002
bo01(6,i)=q6002
for l=0,12 do begin
for m=0,12 do begin
for n=0,12 do begin
if m01[l]+m01[m]+m01[n] eq 0 then begin
wig601=wigner_threej(6,6,6,m01[l],m01[m],m01[n])
wig602(l,m,n)=wig601*qq6a[l]*qq6a[m]*qq6a[n]
wig603(l,m,n)=wig601*q6a[l]*q6a[m]*q6a[n]
endif
endfor
endfor
endfor
for l=0,8 do begin
for m=0,8 do begin
for n=0,8 do begin
if mm01[l]+mm01[m]+mm01[n] eq 0 then begin
wig401=wigner_threej(4,4,4,mm01[l],mm01[m],mm01[n])
wig402(l,m,n)=wig401*qq4a[l]*qq4a[m]*qq4a[n]
wig403(l,m,n)=wig401*q4a[l]*q4a[m]*q4a[n]
endif
endfor
endfor
endfor
wig66(0,i)=real_part(total(wig602))
ym6=(total((abs(qq6a))^2))^1.5
wig66(0,i)=wig66(0,i)/ym6
wig6(0,i)=real_part(total(wig603))
ym61=(total((abs(q6a))^2))^1.5
wig6(0,i)=wig6(0,i)/ym61
wig44(0,i)=real_part(total(wig402))
ym4=(total((abs(qq4a))^2))^1.5
wig44(0,i)=wig44(0,i)/ym4
wig4(0,i)=real_part(total(wig403))
ym41=(total((abs(q4a))^2))^1.5
wig4(0,i)=wig4(0,i)/ym41
endif
if ncountj lt 7.0 and wb[0] ne-1 then begin
qqc1=qqa1(0,w1)
qqcc1=(total(qqc1(0,wb))+qqa1(0,i))/(1.0+ncountjj)
qqc2=qqa1(1,w1)
qqcc2=(total(qqc2(0,wb))+qqa1(1,i))/(1.0+ncountjj)
qqc3=qqa1(2,w1)
qqcc3=(total(qqc3(0,wb))+qqa1(2,i))/(1.0+ncountjj)
qqc4=qqa1(3,w1)
qqcc4=(total(qqc4(0,wb))+qqa1(3,i))/(1.0+ncountjj)
qqc5=qqa1(4,w1)
qqcc5=(total(qqc5(0,wb))+qqa1(4,i))/(1.0+ncountjj)
qqc6=qqa1(5,w1)
qqcc6=(total(qqc6(0,wb))+qqa1(5,i))/(1.0+ncountjj)
qqc7=qqa1(6,w1)
qqcc7=(total(qqc7(0,wb))+qqa1(6,i))/(1.0+ncountjj)
qqc8=qqa1(7,w1)
qqcc8=(total(qqc8(0,wb))+qqa1(7,i))/(1.0+ncountjj)
qqc9=qqa1(8,w1)
qqcc9=(total(qqc9(0,wb))+qqa1(8,i))/(1.0+ncountjj)
qqc10=qqa1(9,w1)
qqcc10=(total(qqc10(0,wb))+qqa1(9,i))/(1.0+ncountjj)
qqc11=qqa1(10,w1)
qqcc11=(total(qqc11(0,wb))+qqa1(10,i))/(1.0+ncountjj)
qqc12=qqa1(11,w1)
qqcc12=(total(qqc12(0,wb))+qqa1(11,i))/(1.0+ncountjj)
qqc13=qqa1(12,w1)
qqcc13=(total(qqc13(0,wb))+qqa1(12,i))/(1.0+ncountjj)
qqd1=qqb1(0,w1)
qqdd1=(total(qqd1(0,wb))+qqb1(0,i))/(1.0+ncountjj)
qqd2=qqb1(1,w1)
qqdd2=(total(qqd2(0,wb))+qqb1(1,i))/(1.0+ncountjj)
qqd3=qqb1(2,w1)
qqdd3=(total(qqd3(0,wb))+qqb1(2,i))/(1.0+ncountjj)
qqd4=qqb1(3,w1)
qqdd4=(total(qqd4(0,wb))+qqb1(3,i))/(1.0+ncountjj)
qqd5=qqb1(4,w1)
qqdd5=(total(qqd5(0,wb))+qqb1(4,i))/(1.0+ncountjj)
qqd6=qqb1(5,w1)
qqdd6=(total(qqd6(0,wb))+qqb1(5,i))/(1.0+ncountjj)
qqd7=qqb1(6,w1)
qqdd7=(total(qqd7(0,wb))+qqb1(6,i))/(1.0+ncountjj)
qqd8=qqb1(7,w1)
qqdd8=(total(qqd8(0,wb))+qqb1(7,i))/(1.0+ncountjj)
qqd9=qqb1(8,w1)
qqdd9=(total(qqd9(0,wb))+qqb1(8,i))/(1.0+ncountjj)
qq6a=[qqcc1,qqcc2,qqcc3,qqcc4,qqcc5,qqcc6,qqcc7,qqcc8,qqcc9,qqcc10,qqcc11,qqcc12,qqcc13]
qq4a=[qqdd1,qqdd2,qqdd3,qqdd4,qqdd5,qqdd6,qqdd7,qqdd8,qqdd9]
q6a=qqa1(*,i)
q4a=qqb1(*,i)
q401=(4.0*!pi/9)*((abs(qqdd1))^2+(abs(qqdd2))^2+(abs(qqdd3))^2+(abs(qqdd4))^2+(abs(qqdd5))^2+(abs(qqdd6))^2+(abs(qqdd7))^2+(abs(qqdd8))^2+(abs(qqdd9))^2)
q601=(4.0*!pi/13)*((abs(qqcc1))^2+(abs(qqcc2))^2+(abs(qqcc3))^2+(abs(qqcc4))^2+(abs(qqcc5))^2+(abs(qqcc6))^2+(abs(qqcc7))^2+(abs(qqcc8))^2+(abs(qqcc9))^2+(abs(qqcc10))^2+(abs(qqcc11))^2+(abs(qqcc12))^2+(abs(qqcc13))^2)
q4001=(4.0*!pi/9)*total((abs(q4a))^2)
q6001=(4.0*!pi/13)*total((abs(q6a))^2)
q402=sqrt(q401)
q602=sqrt(q601)
q4002=sqrt(q4001)
q6002=sqrt(q6001)
bo01(1,i)=q402
bo01(2,i)=q602
bo01(5,i)=q4002
bo01(6,i)=q6002
for l=0,12 do begin
for m=0,12 do begin
for n=0,12 do begin
if m01[l]+m01[m]+m01[n] eq 0 then begin
wig601=wigner_threej(6,6,6,m01[l],m01[m],m01[n])
wig602(l,m,n)=wig601*qq6a[l]*qq6a[m]*qq6a[n]
wig603(l,m,n)=wig601*q6a[l]*q6a[m]*q6a[n]
endif
endfor
endfor
endfor
for l=0,8 do begin
for m=0,8 do begin
for n=0,8 do begin
if mm01[l]+mm01[m]+mm01[n] eq 0 then begin
wig401=wigner_threej(4,4,4,mm01[l],mm01[m],mm01[n])
wig402(l,m,n)=wig401*qq4a[l]*qq4a[m]*qq4a[n]
wig403(l,m,n)=wig401*q4a[l]*q4a[m]*q4a[n]
endif
endfor
endfor
endfor
wig66(0,i)=real_part(total(wig602))
ym6=(total((abs(qq6a))^2))^1.5
wig66(0,i)=wig66(0,i)/ym6
wig6(0,i)=real_part(total(wig603))
ym61=(total((abs(q6a))^2))^1.5
wig6(0,i)=wig6(0,i)/ym61
wig44(0,i)=real_part(total(wig402))
ym4=(total((abs(qq4a))^2))^1.5
wig44(0,i)=wig44(0,i)/ym4
wig4(0,i)=real_part(total(wig403))
ym41=(total((abs(q4a))^2))^1.5
wig4(0,i)=wig4(0,i)/ym41
endif
endif
;endif
endfor
bo01(3,*)=wig44
bo01(4,*)=wig66
bo01(7,*)=wig4
bo01(8,*)=wig6
bo01(9:11,*)=tr(0:2,*)
return,bo01
end




