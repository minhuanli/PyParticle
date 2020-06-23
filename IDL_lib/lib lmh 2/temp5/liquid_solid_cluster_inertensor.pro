 res = fltarr(3,3,100000)
 clustersize = fltarr(1,100000)
 k = 0.
 
 for t = 0, 19 do begin 
   print,'time:' + string(t)
   temp = eclip(p11,[18,t,t])
   w=where(temp(5,*) gt 0.33 and temp(8,*) gt 0,nw)
   if nw lt 5 then continue 
   
   idcluster2,temp(*,w),c01,list=s01,deltar=2.5
   
   ww = where(s01(0,*) ge 5 and s01(0,*) lt 2000, nww) 
   if nww eq 0 then continue 
   
      for i = 0,nww-1 do begin 
        clui = selecluster2(temp(*,w),c01=c01,nb=ww(i))
        res(*,*,k) = inertensor(clui,barycenter=1)
        clustersize(0,k) = s01(0,ww(i))
        k = k + 1.
      endfor
 endfor
 
 print,k
 cs = clustersize(0,0:k-1)
 it = res(*,*,0:k-1)
 
 res = fltarr(10,k)
for i = 0l,k-1 do begin 
    
    res(0,i) = cs(0,i) 
    tempit = it(*,*,i)
    evali = hqr(elmhes(tempit),/double)
    eveci = eigenvec(tempit,evali)
    
    evali = real_part(evali)
    eveci = real_part(eveci)
    
    ss = sort(evali)
    ; minimun inertial
    res(1,i) = evali(ss(0))
    spcoor = cv_coord(from_rect=eveci(*,ss(0)),/to_sphere)
    res(2:3,i) = spcoor(0:1)
    
    res(4,i) = evali(ss(1))
    spcoor = cv_coord(from_rect=eveci(*,ss(1)),/to_sphere)
    res(5:6,i) = spcoor(0:1)
    
    ; largest inertial
    res(7,i) = evali(ss(2))
    spcoor = cv_coord(from_rect=eveci(*,ss(2)),/to_sphere)
    res(8:9,i) = spcoor(0:1)

endfor
end