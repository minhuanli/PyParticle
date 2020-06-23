
res = fltarr(10,k)
for i = 0l,k-1. do begin 
    
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
    
    
    