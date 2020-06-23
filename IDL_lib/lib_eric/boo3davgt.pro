;0)q4,1)q6,2)n_bond,3)w6,4)w6_hat,5)q4,6)q6,,7)x,8)y,9)z,10)t,11)id
function boo3davgt,trb,deltar=deltar,bondmax=bondmax
t1=max(trb(7,*))-min(trb(7,*))+1
ta=findgen(t1)+min(trb(7,*))
n1=n_elements(trb(0,*))
s1=size(trb)
if s1[1] eq 9 then begin
b03=fltarr(17,n1)
b03(0:2,*)=trb(0:2,*)
b03(15:16,*)=trb(7:8,*)
endif
if s1[1] eq 8 then begin
b03=fltarr(16,n1)
b03(0:2,*)=trb(0:2,*)
b03(15,*)=trb(7,*)
endif

for t=0,t1-1 do begin
w=where(trb(7,*) eq ta[t])
trc=trb(*,w)
b01=boo3davgg(trb(*,w),deltar=deltar,bondmax=bondmax)
b03(3:11,w)=b01(0:8,*)
b03(14,w)=b01(12,*)
b01a=voronoicell(trb(*,w),maxr=deltar)
b03(12:13,w)=b01a([4,3],*)
print,t
endfor
return,b03
end