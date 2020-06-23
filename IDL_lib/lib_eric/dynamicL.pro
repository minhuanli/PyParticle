
;trk: no break, i.e. no memory is track.pro

function xy2trk0,xyt,xy0,meantrk,range=range

if keyword_set(range) then begin
 n=where(xyt[0,*] gt range[0] and xyt[0,*] lt range[1] and xyt[1,*] gt range[2] and xyt[1,*] lt range[3])
 xyt=xyt[*,n]
 n=0
endif

n=n_elements(xyt[0,*])
res=fltarr(4,n)
res[0:1,*]=xyt[0:1,*]
res[3,*]=xyt[2,*]
res[2,*]=-1
p=where(xyt[2,*] eq 0)
xy0=xyt[*,p]
xyt=0
res[2,p]=findgen(n_elements(p))
trk=track(res,3,dim=2,goodenough=30)
res=0
goodtraj,trk,trk0,xyrange,minlength=minlength,meantrk=meantrk,t0=t0
return,trk0
end

;lengthcut: e.g.1.5a, cut those long bonds near edges
pro dynamicL,xy0, trk,lengthcut,outfile,mydts=mydts

tmax=max(trk[2,*])+1
if not keyword_set(mydts) then begin
; generate the time partition-- about 10 points per decade
	dt = round(1.15^findgen(100))
	dt = dt(uniq(dt))
	w = where( dt le round(tmax-2), ndt )
	dt = dt(w)
endif else begin
	dt = mydts
	ndt = n_elements(dt)
endelse
dim=2
res=fltarr(dim+2,ndt);
res[0,*]=dt

;if not keyword_set(t0) then t0=0
triangulate,xy0[0,*],xy0[1,*],triangles
ubonds,triangles,bonds

goodtraj,trk,goodtrk,[0,500,0,500],minlength=30,0
trk=0
p=where(goodtrk[2,*] eq 0)
trk0=goodtrk[*,p]
;assign initial point of each traj a label correpsonding to bonds
for i=0,n_elements(trk0[0,*])-1 do begin
 r=sqrt((trk0[0,i]-xy0[0,*])^2+(trk0[1,i]-xy0[1,*])^2)
 rmin=min(r,p)
 if rmin gt 0.01 then print,'wrong initial positions' else trk0[2,i]=p
endfor

framepoints,goodtrk[3,*],ntrj,tp
nbd=n_elements(bonds[0,*])
for i=0,nbd-1 do begin
 p1=where(trk0[2,*] eq bonds[0,i],count1)
 p2=where(trk0[2,*] eq bonds[1,i],count2)
 if count1 eq 1 and count2 eq 1 then begin
  p1=p1[0] ;change p1 from array[1] to a number
  p2=p2[0]
  r=sqrt((trk0[0,p1]-trk0[0,p2])^2+(trk0[1,p1]-trk0[1,p2])^2)
;if xy0 has defect, cut bondlength r strictly
;  if r[0] lt lengthcut then begin
 if r[0] lt 12 and r[0] gt 6 then begin
   ntrj1=trk0[3,p1] ;# of the traj with initial label p1, i.e. bond[0,i]
   trj1=goodtrk[0:1,tp[ntrj1]:tp[ntrj1+1]-1]
   ntrj2=trk0[3,p2]
   trj2=goodtrk[0:1,tp[ntrj2]:tp[ntrj2+1]-1]
   bondtrj=trj1-trj2; bondlength traj, take min length of array trju1,2
;a doubel check of neighbors:
if mean(sqrt(bondtrj[0,*]^2+bondtrj[1,*]^2)) gt 2*lengthcut then print, 'wrong'
   res[1:dim+1,*]=res[1:dim+1,*]+T4m2m(bondtrj,dt)
  endif
 endif
endfor

for i=1,dim do res[i,*]=res[i,*]/res[dim+1,*]
res[2,*]=res[2,*]/res[1,*]^2/2.-1;alpha

write_gdf,res,outfile
end

;res: [total dx^2,dx^4,dy^2,dy^4,count] for dim=2,
function T4m2m, traj,dt

res=fltarr(3,n_elements(dt))
L=n_elements(traj[0,*]);traj length
p=where(dt lt L-2,nt);only those delta t < traj length
for i=0,nt-1 do begin
  d2=(traj[0,0:L-1-dt[i]]-traj[0,dt[i]:L-1])^2+(traj[1,0:L-1-dt[i]]-traj[1,dt[i]:L-1])^2
  res[0,i]=total(d2)
  res[1,i]=total(d2^2)
  res[2,i]=L-dt[i]
endfor

return,res
end






