
function meanposition,trb
s=size(trb)
trc=findgen(s[1],s[2])


For j=0,max(trb(s[1]-1,*)) do begin
w=where(trb(s[1]-1,*) eq j)
trc(1,w)=trb(1,w)-mean(trb(1,w))
trc(0,w)=trb(0,w)-mean(trb(0,w))
trc(s[1]-2,w)=trb(s[1]-2,w)
trc(s[1]-1,w)=trb(s[1]-1,w)
Endfor
return,trc
end
