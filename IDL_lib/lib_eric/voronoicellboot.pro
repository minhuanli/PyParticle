;0)q4,1)q6,2)n_bond,3)w6,4)w6_hat,5)q4,6)q6,,7)x,8)y,9)z,10)t,11)id
function voronoicellboot,trb,maxr=maxr
t1=max(trb(12,*))-min(trb(12,*))+1
ta=findgen(t1)+min(trb(12,*))
n1=n_elements(trb(0,*))
s1=size(trb)
if s1[1] eq 14 then begin
b03=fltarr(16,n1)
b03(0:11,*)=trb(0:11,*)
b03(14:15,*)=trb(12:13,*)
endif
if s1[1] eq 13 then begin
b03=fltarr(15,n1)
b03(0:11,*)=trb(0:11,*)
b03(14,*)=trb(12,*)
endif
tt=trb([0,1,2,3,4,5,6,12],*)
for t=0,t1-1 do begin
w=where(tt(7,*) eq ta[t])
trc=tt(*,w)
b01a=voronoicell(trc,maxr=maxr)
b03(12:13,w)=b01a([4,3],*)
print,t
endfor
return,b03
end