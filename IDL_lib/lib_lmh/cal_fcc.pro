;=============================================================================
;=============================================================================
function calfcc_xy,pos10=pos10,pos20=pos20
    w1=sort(abs(pos10(2,*)))
    w2=sort(abs(pos20(2,*)))
    vec1=pos10(*,w1(0))
    temp=fltarr(6)
    for i=0,5 do begin
       temp(i)=cal_angle(vec1,pos20(*,w2(i)))
    endfor
    print,temp
    return,min(temp)
 end
;=============================================================================    
; calculate the angles(cita, pesai,fai) between two ***fcc*** crystals
; data is the database which contains all the particles for searching the nearest neighbours of the cr cluster
; sr is the radius of the projection sphere,  which is usually 5
; rmax and nmax is the parameter in the function selectnearest
; dr is the parameter in the idcluster function for identifying the patchs on the sphere , which is usually 0.3
;output: angle 0)cita 1)pesai 2)fai
;output: pos1, pos2 both have been rotated to the standard axis 
;the function used in this process:  1)citapesai , 2)prjall, 3)prj1, 4)selectnearest, 5)selecluster2 ,6)idcluster, 7)idcenter, 8)cal_angle, 9)rot_citapesai
;the only for fcc function:  part of citapesai(the part without nv), the last calculation of fai
function cal_fcc, cr1=cr1,cr2=cr2,data1=data1, data2=data2, rmax=rmax,pos1=pos1,pos2=pos2,layer=layer
nmax=12
sr=5
dr=0.2
pi=3.1415926
;1)calculate the cita and pesai between the crystal #1 and the standard axises
citapesai,cr1=cr1,data=data1,rmax=rmax,nmax=nmax,dr=dr,ang1,vec, pos10
citapesai,cr1=cr2,data=data2,rmax=rmax,nmax=nmax,dr=dr,ang2,vec2,pos20
  if keyword_set(layer) then begin
     angle=calfcc_xy(pos10=pos10,pos20=pos20)
  endif else begin
     judge=vec(0)*vec2(0)+vec(1)*vec2(1)+vec(2)*vec2(2)
     if judge ge 0 then vec2=vec2 else vec2=-vec2
   ;2)rotate the crystal #1 to the standard axises, and impose the same transform matrix to the crystal 2#, then the angle between 1# and 2# remain unchanged
   ; here we should judge if the cr1 has been rotated tp a correct diraction.  sort the product of v1 and z axis
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
      tempv1(*,i)=rot_citapesai(vec(*,0),cita=ta(0,i),pesai=ta(1,i),fx=0,fy=1,fz=2)
      tp(i)=tempv1(2,i)
     endfor
     w1=reverse(sort(tp)) 
     ang1=ta(*,w1(0))
     pos1r=rot_citapesai(pos10,cita=ang1(0),pesai=ang1(1),fx=0,fy=1,fz=2)
     vec2r=rot_citapesai(vec2(*,0),cita=ang1(0),pesai=ang1(1),fx=0,fy=1,fz=2)

  ;3)calculate the cita and pesai between cr2r and standard axises, then that is the cita and pesai between 1# and 2#
     citapesai,nv=vec2r,ang

     pos2r=rot_citapesai(pos20,cita=ang1(0),pesai=ang1(1),fx=0,fy=1,fz=2)
   ;4) rotate 2# to the standard axis to calculate the angle fai. we also have to judge here
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
      tempv2(*,i)=rot_citapesai(vec2r,cita=ta1(0,i),pesai=ta1(1,i),fx=0,fy=1,fz=2)
      tp1(i)=tempv2(2,i)
     endfor
     w2=reverse(sort(tp1))
     ang=ta1(*,w2(0))
     pos2rr=rot_citapesai(pos2r,cita=ang(0),pesai=ang(1),fx=0,fy=1,fz=2)
     pos1rr=rot_citapesai(pos1r,cita=0,pesai=ang(1),fx=0,fy=1,fz=2)

     tju=fltarr(6)
     for i=0,5 do begin
       tju(i)=cal_angle(pos1rr(*,0),pos2rr(*,i))
     endfor
     fai=min(tju)
     angle=[ang,fai]
     pos1=pos1rr
     pos2=pos2rr
   endelse

return,angle
end



