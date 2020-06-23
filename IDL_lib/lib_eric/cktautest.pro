;project dynamics of time interval dt to modes, (0,*) is probability of each mode, (1,*) is cululative sorted.
function cktautest,trb,evc,dt=dt
trc=trb
t1a=trb(5,*)
n1=n_elements(evc(0,*))
na=max(trb(6,*))+1
t1aa=min(t1a)
t1b=max(t1a)-t1aa+1
t1c=t1aa+findgen(t1b)
for i=0,t1b-1 do begin
wa=where(trb(5,*) eq t1c[i])
id1=na*i
id2=na*(i+1)-1
trc(*,id1:id2)=trb(*,wa)
endfor
ta=trc(5,*)
tb=ta-shift(ta,1.*dt)
w=where(tb eq dt,nt)
dx=trc(0,*)-shift(trc(0,*),1.*dt)
dy=trc(1,*)-shift(trc(1,*),1.*dt)
dx=dx(0,w)
dy=dy(0,w)
dr=[dx,dy]
dr=reform(dr,2*na,nt)
c2=fltarr(nt,n1)
for j=0,nt-1 do begin
c1=matrix_multiply(dr(*,j),evc,/ATRANSPOSE)
c1=c1^2/total(dr(*,j)^2)
c2(j,*)=c1
endfor
c2=rebin(c2,1,n1)
return,c2
end

