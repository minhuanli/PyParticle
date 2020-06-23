;make a crystal cluster as the neighbour patch and idcenter every patch as a point
; data is the database which contains all the particles for searching the nearest neighbours of the cr cluster
; sr is the radius of the projection sphere
; rmax and nmax is the parameter in the function selectnearest
; dr is the parameter in the idcluster function for identifying the patchs on the sphere , which is usually 0.3
; np is patch number, for fcc cluster, the cluster number 18
; the output is every patch's center's position, and the sequence is from large to small cluster
function patch_center, cr=cr ,data=data, sr=sr, rmax=rmax,nmax=nmax,dr=dr,np=np

pjcr=prjall(cpdata=cr, data=data, rm=rmax, nm=nmax)
idcluster2, pjcr,c01,list=s01,deltar=dr
temp=idcenter_all(pjdata=pjcr,c01=c01,s01=s01,np=np)

return,temp

end