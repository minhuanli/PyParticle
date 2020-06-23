;dis is the placement threshhold and percent is the fraction threshold. used to anaysize the displace cluster
function clusterdy,trb,t1=t1,t2=t2,dis=dis,percent=percent,deltar=deltar
if (not keyword_set(dis)) then dis=0.0
w1=where(trb(5,*) eq t1)
pos01=trb(*,w1)
w2=where(trb(5,*) eq t2)
pos02=trb(*,w2)
dx=pos02(0,*)-pos01(0,*)
dy=pos02(1,*)-pos01(1,*)
dr2=dx^2+dy^2
id1=reverse(sort(dr2))
na=round(percent*n_elements(pos01(0,*)))
id2=id1[0:na-1]
dr3=dr2(0,id2)
pos04=pos01(*,id2)
w=where(dr3 gt dis^2,na)
csize=0.0
if na gt 0 then begin
pos03=pos04(*,w)
idcluster2d,pos03,disvector,list=csize,deltar=deltar
endif
return,csize
end