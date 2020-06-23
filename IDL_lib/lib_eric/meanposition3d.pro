;calculate meanpositions of 3d tracked data.
function meanposition3d,trb
s=size(trb)
trc=findgen(s[1],s[2])
id1=trb(8,*)
id2=id1[uniq(id1,sort(id1))]
na=n_elements(id2)
For j=0,na-1 do begin
w=where(trb(8,*) eq id2[j])
trc(1,w)=trb(1,w)-mean(trb(1,w))
trc(0,w)=trb(0,w)-mean(trb(0,w))
trc(2,w)=trb(2,w)-mean(trb(2,w))
trc(3:8,*)=trb(3:8,*)
Endfor
return,trc
end
