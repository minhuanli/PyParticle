;calculate the cita angle between two cry clusters' close packing faces,now fcc only #2016.3.28
; data is the database which contains all the particles for searching the nearest neighbours of the cr cluster
; sr is the radius of the projection sphere
; rmax and nmax is the parameter in the function selectnearest
; dr is the parameter in the idcluster function for identifying the patchs on the sphere , which is usually 0.3
; the output 0)cita1 1)cita2 2)pesai1 3)pesai2
;-----------------------------------------------------
function cal_cita, cr1=cr1,cr2=cr2,data=data, sr=sr, rmax=rmax,nmax=nmax,dr=dr
;1) project all the cr pariticles to a standard sphere
pjcr1=prjall(cpdata=cr1, sr=sr, data=data, rm=rmax, nm=nmax)
pjcr2=prjall(cpdata=cr2, sr=sr, data=data, rm=rmax, nm=nmax)

;2)idcluster the projection particles 
idcluster, pjcr1,c01,deltar=dr,list=s01
idcluster, pjcr2,c02,deltar=dr,list=s02

;3)select the patchs on the closed packing face
w1=reverse(sort(s01(0,*)))
patch11=selecluster2(pjcr1,c01=c01,nb=w1(0))
patch12=selecluster2(pjcr1,c01=c01,nb=w1(2))

w2=reverse(sort(s02(0,*)))
patch21=selecluster2(pjcr2,c01=c02,nb=w2(0))
patch22=selecluster2(pjcr2,c01=c02,nb=w2(2))

;4)find the center of every patch as the vectors, and their cross products
v11=idcenter(patch11)
v12=idcenter(patch12)
v1=crossp(v11,v12)

v21=idcenter(patch21)
v22=idcenter(patch22)
v2=crossp(v21,v22)

;5)calculate the angle 
cita1=cal_angle(v1,[0,0,1])
cita2=cal_angle(v2,[0,0,1])

on1=crossp([0,0,1],v1)
pesai1=cal_angle([1,0,0],on1)

on2=crossp([0,0,1],v2)
pesai2=cal_angle([1,0,0],on2)

temp=fltarr(4)
temp(0)=cita1
temp(1)=cita2
temp(2)=pesai1
temp(3)=pesai2

print,v1
print,v2

return,temp


end
