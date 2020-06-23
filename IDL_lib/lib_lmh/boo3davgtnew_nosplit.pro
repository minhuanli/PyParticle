;average over same phase,bond 13 are splitted to 12 and 14
;calculation bond order 0,x,1,y,2,z,3,solid bond number,4,Q4,5,Q6,
;6,W4,7,W6,8,q4,9,q6,10,w4,11,w6,12,cell volume,13,cell vortice number,14,bond,15,time,16,id.
function boo3davgtnew_nosplit,trb,deltar=deltar,bondmax=bondmax,dc=dc,track=track,st=st
nel=n_elements(trb(*,0))-1
if (not keyword_set(dc)) then dc=0.7
if (keyword_set(track)) then nel=nel-1
ta=trb(nel,*)
ta=ta(uniq(ta,sort(ta)))
nt=n_elements(ta)
n1=n_elements(trb(0,*))
if (keyword_set(track)) then begin
b03=fltarr(17,n1)
b03(0:2,*)=trb(0:2,*)
b03(15:16,*)=trb(nel:nel+1,*)
endif
if (not (keyword_set(track))) then begin
b03=fltarr(16,n1)
b03(0:2,*)=trb(0:2,*)
b03(15,*)=trb(nel,*)
endif

for t=0,nt-1 do begin
w=where(trb(nel,*) eq ta[t])
trc=trb(*,w)
b01=boo3davgnew_test1_nosplit(trb(*,w),deltar=deltar,bondmax=bondmax,dc=dc)
;solid bond number
b03(3,w)=b01(0,*)
;Q4 Q6 NO AVERAGE
b03(4:5,w)=b01(13:14,*)
;W4 W6 
b03(6:7,w)=b01(3:4,*)
;q4 q6 w4 w6 
b03(8:11,w)=b01(5:8,*)
;bond number
b03(14,w)=b01(12,*)
b01a=voronoicell(trb(*,w),maxr=deltar)
b03(12:13,w)=b01a([4,3],*)
print,t
endfor

if (keyword_set(st)) then b03(15,*)=st

return,b03
end
