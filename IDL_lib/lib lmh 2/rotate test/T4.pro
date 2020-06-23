;f1=create_standard_bcc(5,method=2)
;f1norm=sqrt(total(f1^2,1))
;for i=0,13 do f1[*,i]=5*float(f1[0:2,i])/f1norm[i]
;f1=create_standard_rhcp(5)
;euler=euler_matrix_new(875,4524,54,/ZYX,/deg)
;f2=transpose(rotate_coord(transpose(f1[0:2,*]),euler_matrix=euler))
f2=rot_citapesai(f1,cita=1.2,pesai=1786,fx=0,fy=1,fz=2)
f2=[f2,replicate(5,1,14)]
f21=f2
ff2=adjust_neigh(f2,refer=f1,subrefer=f21)
;xplot3d,ff2[0,*],ff2[1,*],ff2[2,*],linestyle=6,symbol=osymbol
;xplot3d,f1[0,*],f1[1,*],f1[2,*],linestyle=1,symbol=osymbol1,/overplot
;xplot3d,ff2[0,*],ff2[1,*],ff2[2,*],linestyle=6,symbol=osymbol
;xplot3d,f2[0,*],f2[1,*],f2[2,*],linestyle=1,symbol=osymbol1,/overplot
;xplot3d,f1[0,*],f1[1,*],f1[2,*],linestyle=1,symbol=osymbol1
end