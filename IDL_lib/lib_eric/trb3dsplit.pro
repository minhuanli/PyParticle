function trb3dsplit,trb,xa=xa,ya=ya,za=za
trc=eclip(trb,[0,xa[0],xa[1]],[1,ya[0],ya[1]],[2,za[0],za[1]])
id1=trc(8,*)
t1=max(trb(7,*))+1
id2=id1[uniq(id1,sort(id1))]
na=n_elements(id2)
trd=findgen(9,t1*na)
for j=0,na-1 do begin
w=where(trb(8,*) eq id2[j])
trd(*,t1*j:t1*(j+1)-1)=trb(*,w)
endfor
return,trd
end
