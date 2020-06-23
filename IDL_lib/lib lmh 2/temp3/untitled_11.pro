;boo = [bc(0,*),bc(2,*),bc(1,*),bc(5:17,*),class]
; 16 class index, 15 time index
for i = 0,1000 do begin
  booi = boo(*,where(boo(15,*) eq i))
  
  booi = eclip(booi,[0,10,80],[1,5,45],[2,10,80])
  
  d1 = booi(0:2,where(booi(16,*) ge 7))
  
  w2 = where(booi(16,*) eq 2 or booi(16,*) eq 5,nw2)
 ;w2 = where(where(booi(16,*) eq 5,nw2))
  if nw2 eq 0 then continue
  d2 = booi(0:2,w2)
  
  w3 = where(booi(16,*) eq 1 or booi(16,*) eq 4,nw3)
 ;w3 = where(where(booi(16,*) eq 4,nw3))
  if nw3 eq 0 then continue
  d3 = booi(0:2,w3)
  
  w4 = where(booi(16,*) eq 3 or booi(16,*) eq 6,nw4)
 ;w4 = where(where(booi(16,*) eq 4,nw4))
  if nw4 eq 0 then continue
  d4 = booi(0:2,w4)
  
  povlmh42,d1,d2,d3,d4,0.1,1.2,1.2,1.2,'D:\liminhuan\pre2solid fluc\simudata\07tmlocalorder\pov'+string(i)+'.pov'
  print,i
endfor

end
  
  