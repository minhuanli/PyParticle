;0)q4,1)q6,2)n_bond,3)w6,4)w6_hat,5)q4,6)q6,,7)x,8)y,9)z,10)t,11)id
function boo3davgtq8,trb,deltar=deltar,bondmax=bondmax
t1=max(trb(7,*))-min(trb(7,*))+1
ta=findgen(t1)+min(trb(7,*))
n1=n_elements(trb(0,*))
s1=size(trb)
if s1[1] eq 9 then begin
b03=fltarr(21,n1)
b03(0:2,*)=trb(0:2,*)
b03(19:20,*)=trb(7:8,*)
endif
if s1[1] eq 8 then begin
b03=fltarr(20,n1)
b03(0:2,*)=trb(0:2,*)
b03(19,*)=trb(7,*)
endif

for t=0,t1-1 do begin
w=where(trb(7,*) eq ta[t])
trc=trb(*,w)
b01=boo3davggq8(trb(*,w),deltar=deltar,bondmax=bondmax)
b03(3:15,w)=b01(0:12,*)
b03(18,w)=b01(16,*)
b01a=voronoicell(trb(*,w),maxr=deltar)
b03(16:17,w)=b01a([4,3],*)
print,t
endfor
return,b03
end