
function meanposition1,trb
s=size(trb)
trc=findgen(s[1],s[2])


For j=0,max(trb(3,*)) do begin
w=where(trb(3,*) eq j)
trc(1,w)=trb(1,w)-mean(trb(1,w))
trc(0,w)=trb(0,w)-mean(trb(0,w))
trc(2,w)=trb(2,w)
trc(3,w)=trb(3,w)
Endfor
return,trc
end
