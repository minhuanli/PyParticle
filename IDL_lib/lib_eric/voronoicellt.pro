function voronoicellt,trb,maxr=maxr
t1=max(trb(7,*))-min(trb(7,*))+1
ta=findgen(t1)+min(trb(7,*))
n1=n_elements(trb(0,*))
s1=size(trb)
if s1[1] eq 9 then begin
b03=fltarr(8,n1)
;b03(0:2,*)=trb(0:2,*)
b03(6:7,*)=trb(7:8,*)
endif
if s1[1] eq 8 then begin
b03=fltarr(7,n1)
;b03(0:2,*)=trb(0:2,*)
b03(6,*)=trb(7,*)
endif
for t=0,t1-1 do begin
w=where(trb(7,*) eq ta[t])
trc=trb(*,w)
b01=voronoicell(trc,maxr=maxr)
b03(0:5,w)=b01(0:5,*)
print,t
endfor
return,b03
end