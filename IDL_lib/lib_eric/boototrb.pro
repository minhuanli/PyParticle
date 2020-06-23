function boototrb,boo
n1=max(boo(11,*))-min(boo(11,*))+1
t1=max(boo(10,*))-min(boo(10,*))+1
n11=n_elements(boo(0,*))
trb=fltarr(9,n11)
for j=0,n1-1 do begin
w=where(boo(11,*) eq j)
c1=t1*j
c2=t1*j+t1-1
trb(0,c1:c2)=boo(7,w)
trb(1,c1:c2)=boo(8,w)
trb(2,c1:c2)=boo(9,w)
trb(3,c1:c2)=boo(2,w)
trb(4,c1:c2)=boo(5,w)
trb(5,c1:c2)=boo(6,w)
trb(6,c1:c2)=boo(3,w)
trb(7,c1:c2)=boo(10,w)
trb(8,c1:c2)=boo(11,w)
print,j
endfor
return,trb
end
