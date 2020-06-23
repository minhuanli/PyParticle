
function picktopo, data,tr33

w=where(tr33(4,*) gt 12)
temp=data(*,w)
w=where(temp(3,*) lt 3)
topo=temp(*,w)

return,topo

end