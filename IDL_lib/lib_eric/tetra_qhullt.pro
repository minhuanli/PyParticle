;tr2 contains the tetra network(tetra index in 0,1,2,3) 4 is the tetra volume, 5 is the tetracity, 
;tr3 is the tetra profile of each particle. 0,1,2 is position, 3 is tetracity, 4 is number of tetra ,5 is total
pro tetra_qhullt,trb,tr22,tr33
tcol=n_elements(trb(*,0))
t1=max(trb(tcol-1,*))-min(trb(tcol-1,*))+1
ta=findgen(t1)+min(trb(tcol-1,*))
n1=n_elements(trb(0,*))
s1=size(trb)
;if s1[1] eq tcol-1 then begin
;b03=fltarr(8,n1)
;b03(0:2,*)=trb(0:2,*)
;b03(6:7,*)=trb(7:8,*)
;tr22=fltarr(11,1)
;endif
if s1[1] eq tcol then begin
b03=fltarr(7,n1)
;b03(0:2,*)=trb(0:2,*)
b03(6,*)=trb(tcol-1,*)
tr22=fltarr(10,1)
endif
for t=0,t1-1 do begin
w=where(trb(tcol-1,*) eq ta[t])
trc=trb(*,w)
tetra_qhull,trc,tr2,tr3
b03(0:5,w)=tr3(0:5,*)
n11=n_elements(tr2(0,*))
t01=fltarr(1,n11)+ta[t]
tr2=[tr2,t01]
tr22=[[tr22],[tr2]]
print,t
endfor
n1a=n_elements(tr22(0,*))
tr22=tr22(*,1:n1a-1)
tr33=b03
end
