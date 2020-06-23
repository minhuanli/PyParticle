function position3d,trb
s=size(trb)
trc=findgen(s[1],s[2])
id1=trb(8,*)
id2=id1[uniq(id1,sort(id1))]
na=n_elements(id2)
position01=findgen(4,na)
For j=0,na-1 do begin
w=where(trb(8,*) eq id2[j])
position01(0,j)=mean(trb(0,w))
position01(1,j)=mean(trb(1,w))
position01(2,j)=mean(trb(2,w))
position01(3,j)=id2[j]
Endfor
return,position01
end