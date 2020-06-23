;tetraadj cluster analyze, input data should be the "data" of intersted tetras which contains the tetra indice , pos is the position of all particles.
;tetracluster (*,j) contain the eigen 
;vectors of the tetra cluster size in list(0,j), list(1,j) is the 
;particles in tetracluster, pcluster(*,j) contains the particle id in jth cluster
;a sample, I often use: tr1=tetra_qhull(pt), then id is the interested particles, 
;tr2=postotetra(id,tr1) will find the tetra id includs, we can also find the intereted tetra tr2, then  facecluster,tr2,pt(0:2,*),tetra
;cluster,pcluster,list=list will find the tetra network cluster.
;if i want to find tetra network of hcp particles
;pt=read_gdf('F://pt_.....')
;b01=read_gdf('F://boo3davgt_...')
;tetra_qhullt,pt,tr22,tr33  (tr22 is tetras , tr33 is particles tetracity)
;w=where(pt(7,*) eq 10) time series
;pta=pt(*,w)
;w1=where(tr22(6,*) eq 10)
;tr222=tr22(*,w) find the time series of tetra
;b02=b01(*,w)
;b02(15,*)=findgen(n_elements(b02(0,*)) set partical id
;w=where(b02(3,*) gt 7 and b02(14,*) gt 11 and b02(14,*) lt 13)
;p01=polycut(b02(*,w),f1=8,f2=10)  find interested particles, such as hcp, fcc, polycut is useful
;t01=postotetra(p01(15,*),tr222(0:8,*)
;w=where(t01(5,*) lt 0.1) find tetras with tetracity lt 0.1
;facecluster,t01(*,w),pta(0:2,*),tc1,pc1,list=s1
pro facecluster,data,pos,tetracluster,pcluster,list=list
tr1=data(0:3,*)
data3=pos(0:2,*)
n11=n_elements(data3(0,*))
n1=n_elements(data(0,*))
;qhull,data(0:2,*),tr1,/delaunay
idd=fltarr(n1)
data1=fltarr(n1)
list1=0
repeat begin
id0=fltarr(n1)
w=where(idd eq 0,na)
if na gt 0 then begin
ida=faceloop(tr1,w[0])
idd[ida]=1
id0[ida]=1
data1=[[data1],[id0]]
ndd=n_elements(ida)
list1=[list1,ndd]
endif
endrep until na eq 0
nb=n_elements(data1(0,*))
data2=data1(*,1:nb-1)
lista=list1(1:nb-1)
list=fltarr(3,nb-1)
list(0,*)=lista
gy01=fltarr(2,nb-1)
data4=fltarr(n11,nb-1)
;tra=tr1[uniq(tr1,sort(tr1))]
for j=0.,nb-2 do begin
w=where(data2(*,j) eq 1,ns)
c1=tr1(*,w)
c2=c1[uniq(c1,sort(c1))]
npp=n_elements(c2)
for t=0.,npp-1 do begin
wpp=where(c1 eq c2[t],nkk)
data4(c2[t],j)=nkk
endfor
r1=n_elements(c2)
gy01[0,j]=r1
dr=fltarr(3,ns)
for k=0.,ns-1 do begin
dr(0,k)=mean(pos(0,c1(0:3,k)))
dr(1,k)=mean(pos(1,c1(0:3,k)))
dr(2,k)=mean(pos(2,c1(0:3,k)))
endfor
x0=mean(dr(0,*))
y0=mean(dr(1,*))
z0=mean(dr(2,*))
r11=sqrt(mean((dr(0,*)-x0)^2+(dr(1,*)-y0)^2+(dr(2,*)-z0)^2))
gy01[1,j]=r11
endfor
list(1:2,*)=gy01
tetracluster=data2
pcluster=data4
end


