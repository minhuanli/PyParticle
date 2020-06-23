;make a crystal cluster as the neighbour patch and idcenter every patch as a point
; data is the database which contains all the particles for searching the nearest neighbours of the cr cluster
; sr is the radius of the projection sphere
; rmax and nmax is the parameter in the function selectnearest
; dr is the parameter in the idcluster function for identifying the patchs on the sphere , which is usually 0.3
;n is patch number, for fcc cluster, the cluster number 18
;the output is every patch's center's position, and the sequence is from large to small cluster
function patch_center_bcc, cr=cr ,data=data, sr=sr, rmax=rmax,nmax=nmax,dr=dr,np=np

pjcr=prjall_bcc(cpdata=cr, sr=sr, data=data, rm=rmax, nm=nmax)
idcluster, pjcr,c01,deltar=dr,list=s01
temp=idcenter_all(pjdata=pjcr,c01=c01,s01=s01,np=np)

dis1=fltarr(1,14)
for i=0,13 do begin
  dis1(i)=(temp(0,i))^2 + (temp(1,i))^2 + (temp(2,i))^2
endfor
temp=[dis1,temp]
w=reverse(sort(temp(0,*)))
temp=temp(*,w)

return,temp

end