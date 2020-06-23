
;calculate the cita ande pesai between the fcc crystal and the origin xyz axises
;angle contains the cita and pesai
;vector contains the normal vector of the closed packing face, 0)v1 1)v11 2)v12
pro citapesai, cr1=cr1, data=data, sr=sr, rmax=rmax,nmax=nmax,dr=dr,nv=nv,angle,vector,pos

if (keyword_set(nv)) then begin 
  v1=nv 
endif else begin 
  ;1) project all the cr pariticles to a standard sphere
  pjcr1=prj_voi(cpdata=cr1, data=data, dr=rmax, nm=nmax)
 
  ;2)idcluster the projection particles 
 ; idcluster, pjcr1,c01,deltar=dr,list=s01
  ;3)select the patchs on the closed packing face
 ; w1=reverse(sort(s01(0,*)))
 ; tempp=fltarr(3,18)
 ; for i=0,17 do begin
 ;  temppatch=selecluster2(pjcr1,c01=c01,nb=w1(i))
 ;   tempp(*,i)=idcenter(temppatch)
 ; endfor
    
  ;patch11=selecluster2(pjcr1,c01=c01,nb=w1(0))
  ;patch12=selecluster2(pjcr1,c01=c01,nb=w1(2))
  ;4)find the center of every patch as the vectors, and their cross products
  
  pos=latt_rhcp(prj=pjcr1,dc=0.1,ampli=3.)
  
  v11=pos(0:2,0)
  v12=pos(0:2,2)
  v1=crossp(v11,v12)
  vector=[[v1],[v11],[v12]]
 ;pos=tempp
endelse
;5)calculate the angle 
cita1=cal_angle(v1,[0,0,1])
on1=crossp([0,0,1],v1)
pesai1=cal_angle([1,0,0],on1)

temp=fltarr(2)
temp(0)=cita1
temp(1)=pesai1

angle=temp
end


