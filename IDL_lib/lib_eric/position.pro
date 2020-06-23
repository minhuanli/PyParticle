function position,trb
dim1=n_elements(trb(*,0))
naa=trb(dim1-1,*)
nab=naa[uniq(naa)]
l=n_elements(nab)
position01=Findgen(3,l)
For j=0,l-1 do begin
w=where(trb(dim1-1,*) eq nab[j])
position01(0,j)=mean(trb(0,w))
position01(1,j)=mean(trb(1,w))
position01(2,j)=nab[j]
Endfor
return,position01
end