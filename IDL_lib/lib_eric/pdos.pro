function pdos,dcm,pos
s=size(dcm)
s1=s[1]/2
a=findgen(s1,s1)
a1=findgen(s1,s1)
for j=0,s1-1 do begin
for k=0,s1-1 do begin
a(j,k)=dcm(2*j,2*k)
a1(j,k)=dcm(2*j+1,2*k+1)
endfor
endfor
a2=findgen(s1)
for i=0,s1-1 do begin
a3=mean(a(*,i))+mean(a1(*,i))
a2[i]=a3
endfor
grid1=griddata(pos(0,*),pos(1,*),a2,dimension=512)
grid2=abs(grid1)
tvscl,grid2
return,grid2
end