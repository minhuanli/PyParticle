boxt = eclip(boo1c,[0,40,60],[1,30,50],[2,15,35])

for i = 0,499 do begin
print,i
boxti = eclip(boxt,[15,i,i])  ;
pboxti = eclip(boxti,[16,1,6]) ; particle with order

idcluster2,pboxti(0:2,*),c01,list=s01,deltar=4.6 
clu1 = selecluster(data=pboxti, c01=c01, s01=s01, sc=max(s01(0,*)))
w2 = where(clu1(16,*) eq 2 or clu1(16,*) eq 5,nw2)
w3 = where(clu1(16,*) eq 1 or clu1(16,*) eq 4,nw3)
w4 = where(clu1(16,*) eq 3 or clu1(16,*) eq 6,nw4)
if nw2 eq 0 then continue else d2 = clu1(*,w2)
if nw3 eq 0 then continue else d3 = clu1(*,w3)
if nw4 eq 0 then continue else d4 = clu1(*,w4)
povlmh4,boxti,d2,d3,d4,0.05,1.6,1.6,1.6,'D:\liminhuan\pre2solid fluc\booseries009data\cluster_pov\pov'+string(i)+'.pov'

endfor

end 