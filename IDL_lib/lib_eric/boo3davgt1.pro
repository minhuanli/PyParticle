;boo contains all bond parameter for the tracked data. ID1 is the id number of required data.
function boo3davgt1,boo,id
id2=id
bo1=boo
na=n_elements(id2)
pa=findgen(5,na)
for j=0,na-1 do begin
w=where(bo1(11,*) eq id2[j])
pa(0,j)=mean(bo1(7,w))
pa(1,j)=mean(bo1(8,w))
pa(2,j)=mean(bo1(9,w))
pa(3,j)=mean(bo1(1,w))
pa(4,j)=mean(bo1(11,w))
endfor
return,pa
end



