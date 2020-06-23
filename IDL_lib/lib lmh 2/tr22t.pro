function tr22t,bond 
  ncol=n_elements(bond(*,0))
  tmax=max(bond(ncol-1,*))
  tmin=min(bond(ncol-1,*))
  tr22=fltarr(10,1)
  for t = tmin,tmax do begin
    w=where(bond(ncol-1,*) eq t,nw)
    if nw eq 0 then continue
    bondt=bond(*,w)
    c1=bondt(0:2,*)
    qhull,c1,tr1,connectivity=con1,/delaunay
    na=n_elements(tr1(0,*))
    tr2=fltarr(10,na)
    tr2(0:3,*)=tr1
    for j=0.,na-1 do begin
      w11=tr1(*,j)
      pos=c1(*,w11)
      va=tetra_volume(pos,[0,1,2,3])
      dx=[pos(0,0)-pos(0,1),pos(0,0)-pos(0,2),pos(0,0)-pos(0,3),pos(0,1)-pos(0,2),pos(0,1)-pos(0,3),pos(0,2)-pos(0,3)]
      dy=[pos(1,0)-pos(1,1),pos(1,0)-pos(1,2),pos(1,0)-pos(1,3),pos(1,1)-pos(1,2),pos(1,1)-pos(1,3),pos(1,2)-pos(1,3)]
      dz=[pos(2,0)-pos(2,1),pos(2,0)-pos(2,2),pos(2,0)-pos(2,3),pos(2,1)-pos(2,2),pos(2,1)-pos(2,3),pos(2,2)-pos(2,3)]
      dr=sqrt(dx^2+dy^2+dz^2)
      s01=stddev(dr)/mean(dr)
      tr2(7,j)=va
      tr2(8,j)=s01
      tr2(4,j)=mean(pos(0,[0,1,2,3]))
      tr2(5,j)=mean(pos(1,[0,1,2,3]))
      tr2(6,j)=mean(pos(2,[0,1,2,3]))
    endfor
    tr2(9,*)=t
    tr22=[[tr22],[tr2]]
  endfor
  nb=n_elements(tr22(0,*))
  tr22=tr22(*,1:nb-1)
  
  return,tr22

end
   