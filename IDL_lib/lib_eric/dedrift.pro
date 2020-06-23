function dedrift,trb,length=length
pos=position(trb)
a=length
t1=trb(5,*)
n1=trb(6,*)
t2=t1[uniq(t1,sort(t1))]
n2=n1[uniq(n1,sort(n1))]
t=n_elements(t2)
n=n_elements(n2)
for j=0,n-1 do begin
pos1=pos
w=where(trb(0,*) gt pos1(0,j)-a and trb(0,*) lt pos1(0,j)+a and trb(1,*) gt pos1(1,j)-a and trb(1,*) lt pos1(1,j)+a )
if w[0] ne -1 then begin
trc=trb(*,w)
mot=motion(trc)
trd=rm_motion(trc,mot,smooth=1)
trb(*,w)=trd
print,j
endif
endfor
tre=trb
return,tre
end
