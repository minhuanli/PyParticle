;no average over same phase
;calculation bond order 0,x,1,y,2,z,3,solid bond number,4,Q4,5,Q6,
;6,W4,7,W6,8,q4,9,q6,10,w4,11,w6,12,cell volume,13,cell vortice number,14,bond,15,time,16,id.
function boo3davgtaa,trb,deltar=deltar,bondmax=bondmax
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
b01=boo3davggaa(trb(*,w),deltar=deltar,bondmax=bondmax)
b03(3:11,w)=b01(0:8,*)
b03(14,w)=b01(12,*)
;b01a=voronoicell(trb(*,w),maxr=deltar)
;b03(12:13,w)=b01a([4,3],*)
print,t
endfor
return,b03
end



