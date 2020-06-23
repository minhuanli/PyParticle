;calculate the angles(cita, pesai,fai) between two ***bcc*** crystals
; data is the database which contains all the particles for searching the nearest neighbours of the cr cluster
; sr is the radius of the projection sphere,  which is usually 5
; rmax and nmax is the parameter in the function selectnearest
; dr is the parameter in the idcluster function for identifying the patchs on the sphere , which is usually 0.3
;output: angle 0)cita 1)pesai 2)fai
;output: pos1, pos2 both have been rotated to the standard axis 
;the function used in this process:  1)citapesai , 2)prjall, 3)prj1, 4)selectnearest, 5)selecluster2 ,6)idcluster, 
;7)idcenter, 8)cal_angle, 9)rot_citapesai 10)patch_center 11)grobcc
pro cal_posbcc, pos10=pos10,pos20=pos20,angle
nmax=15
sr=5
dr=0.3
pi=3.1415927
;1)project to the sphere and identify the patch centers
pos10=grobcc(pos=pos10)
pos20=grobcc(pos=pos20)
;3)calculate the citaand pesai between 1# and the standard axis
nv1=pos10(1:3,0)
tju=fltarr(6)
for i=0,5 do begin
  tnv2=pos20(1:3,i)
  tju(i)=tnv2(0)*nv1(0)+tnv2(1)*nv1(1)+tnv2(2)*nv1(2)
endfor
w=reverse(sort(tju))
pos20(*,0:5)=pos20(*,w)
nv2=pos20(1:3,0)  
  
citapesai,nv=nv1,ang1

;4)rotate the 1# to the standard coordinationa and impose the same trans matrix to the 2#
; here we should judge if the cr1 has been rotated to a correct diraction.  sort the product of v1 and z axis
ta=fltarr(2,4)
ta(0,0)=ang1(0)
ta(1,0)=ang1(1)
ta(0,1)=ang1(0)
ta(1,1)=-ang1(1)
ta(0,2)=-ang1(0)
ta(1,2)=ang1(1)
ta(0,3)=-ang1(0)
ta(1,3)=-ang1(1)
tempv1=fltarr(3,4)
tp=fltarr(4)
for i=0,3 do begin
  tempv1(*,i)=rot_citapesai(nv1,cita=ta(0,i),pesai=ta(1,i),fx=0,fy=1,fz=2)
  tp(i)=tempv1(2,i)
endfor
w1=reverse(sort(tp))
ang1=ta(*,w1(0))
pos1r=rot_citapesai(pos10,cita=ang1(0),pesai=ang1(1),fx=1,fy=2,fz=3)
pos2r=rot_citapesai(pos20,cita=ang1(0),pesai=ang1(1),fx=1,fy=2,fz=3)
nv2r=rot_citapesai(nv2,cita=ang1(0),pesai=ang1(1),fx=0,fy=1,fz=2)

;5)calculate the cita and pesai between 2# and 1#. rotate 2# to standard coordination also
citapesai,nv=nv2r,ang
ta1=fltarr(2,4)
ta1(0,0)=ang(0)
ta1(1,0)=ang(1)
ta1(0,1)=ang(0)
ta1(1,1)=-ang(1)
ta1(0,2)=-ang(0)
ta1(1,2)=ang(1)
ta1(0,3)=-ang(0)
ta1(1,3)=-ang(1)
tempv2=fltarr(3,4)
tp1=fltarr(4)
for i=0,3 do begin
  tempv2(*,i)=rot_citapesai(nv2r,cita=ta1(0,i),pesai=ta1(1,i),fx=0,fy=1,fz=2)
  tp1(i)=tempv2(2,i)
endfor
w2=reverse(sort(tp1))
tang=ta1(*,w2(0))

print,tang

pos2rr=rot_citapesai(pos2r,cita=tang(0),pesai=tang(1),fx=1,fy=2,fz=3)
pos1rr=rot_citapesai(pos1r,cita=0,pesai=tang(1),fx=1,fy=2,fz=3)
;6)calculate fai
w=reverse(sort(pos1rr(3,1:5)))
pos1rr(*,1:5)=pos1rr(*,w+1)
w1=reverse(sort(pos2rr(3,1:5)))
pos2rr(*,1:5)=pos2rr(*,w1+1)
tju1=fltarr(4)
for i=0,3 do begin 
  tju1(i)=cal_angle(pos1rr(1:3,1),pos2rr(1:3,i+1))
endfor
fai=min(tju1)
angle=[ang,fai]

angle(0:2)=(angle(0:2)/pi)*180

pos1=pos1rr
pos2=pos2rr




end