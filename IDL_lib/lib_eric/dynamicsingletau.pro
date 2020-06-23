function dynamicsingletau,trb
id1=trb(6,*)
id1=id1[uniq(id1,sort(id1))]
n1=n_elements(id1)
a1=1.15^findgen(100)
tmax=max(trb(5,*))-min(trb(5,*))
w=where(a1 lt tmax)
ta=round(a1[w])
tb=ta(uniq(ta,sort(ta)))
n2=n_elements(tb)
dr1=fltarr(n2,n1+1)
dr1(*,0)=tb
for i=0,n1-1 do begin
w1=where(trb(6,*) eq id1[i])
trc=trb(*,w1)
for j=0,n2-1 do begin
idt=trc(5,*)-shift(trc(5,*),tb[j])
dx=trc(0,*)-shift(trc(0,*),tb[j])
dy=trc(1,*)-shift(trc(1,*),tb[j])
w2=where(idt eq tb[j])
dr=mean(dx[0,w2]^2+dy[0,w2]^2)
dr1(j,i+1)=dr
endfor
;print,i
endfor
return,dr1
end