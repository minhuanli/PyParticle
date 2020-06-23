;dynamics mapping: 0)mod number 1)ratio 2)realdis 3)cumulative
function ckt,trb,evc,t1=t1,t2=t2
nbb=n_elements(evc(0,*))
w1=where(trb(5,*) eq t1)
pos1=trb(*,w1)
w2=where(trb(5,*) eq t2)
pos2=trb(*,w2)
n2=size(pos1)
n1=n2[2]
dr1=pos2(0,*)-pos1(0,*)
dr2=pos2(1,*)-pos1(1,*)
xmax=abs(max(pos2(0,*))-min(pos2(0,*)))
ymax=abs(max(pos2(1,*))-min(pos2(1,*)))
wa=where(dr1 gt xmax,n1a)
if n1a gt 0 then dr1(0,wa)=dr1(0,wa)-1.0
wb=where(dr1 lt -xmax,n2a)
if n2a gt 0 then dr1(0,wb)=dr1(0,wb)+1.0
wc=where(dr2 gt ymax,n3a)
if n3a gt 0 then dr2(0,wc)=dr2(0,wc)-1.0
wd=where(dr2 lt -ymax,n4a)
if n4a gt 0 then dr2(0,wd)=dr2(0,wd)-1.0
dr3=fltarr(2,n1)
dr3(0,*)=dr1
dr3(1,*)=dr2
dr4=reform(dr3,2*n1,1)
p=fltarr(1,nbb)
For i=0,nbb-1 do begin
p2=total(evc(*,i)*dr4)
p[i]=p2
Endfor
w1=reverse(sort(p^2))
r2=total(dr4^2)
p1=p^2/r2
p3=p/1.0
ck1=fltarr(4,nbb)
ck1(0,*)=1+findgen(1,nbb)
ck1(1,*)=p1
ck1(2,*)=p3
ck1(3,*)=total(p1(0,reverse(sort(p1))),/cumulative)
return,ck1
end