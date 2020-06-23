function sq1,pos
p6=psi6(pos,polar=1)
w=where(p6(0,*) gt mean(p6(0,*)))
n1=n_elements(w)
a1=findgen(2,n1)
a1(0,*)=pos(0,w)
a1(1,*)=pos(1,w)
s2=sq(a1)
return,s2
end