pro p6a,trb,border,trd,pb
na=n_elements(trb(0,*))
pa=complexarr(1,na)
tmin=min(trb(5,*),max=tmax)
for t=tmin,tmax do begin
w=where(trb(5,*) eq t)
trc=trb(*,w)
p6=transpose(psi6(trc))
pa(0,w)=p6
endfor
wa=where(trb(0,*) gt border(0) and trb(0,*) lt border(1) and trb(1,*) gt border(2) and trb(1,*) lt border(3))
trd=trb(*,wa)
pb=pa(0,wa)
end