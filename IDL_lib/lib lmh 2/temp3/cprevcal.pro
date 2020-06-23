cp = clu1(*,53)
id = clu1(16,53)

w=where(boo1t(16,*) eq id, nw)
cpvoi = fltarr(18,nw)
cps12 = fltarr(18,nw)
cpall = boo1t(*,w)

for t = 0, nw-1 do begin
print,t
time = cpall(15,t)
; voi part 
bvt = eclip(bv,[17,time,time])
cpvoi(*,t) = bvt(0:17,findid(cpdata=cpall(0:2,t),data=bvt)) 

;12 boo part
cpx = cpall(0,t)
cpy = cpall(1,t)
cpz = cpall(2,t)
bsbox = eclip(boo1,[15,time,time],[0,cpx-10,cpx+10],[1,cpy-10,cpy+10],[2,cpz-10,cpz+10])     ;cut a box at time t for boo12 cal
bsbox12 = bondvoi(bsbox(0:15,*),method=2,dr=4.6,bondmax=12)
cps12(*,t) = bsbox12(0:17,findid(cpdata=cpall(0:2,t),data=bsbox12))

endfor

end










