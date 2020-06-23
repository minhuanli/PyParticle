function averagesqw,s1,evs,s01
n1=n_elements(evs)
omg1=1./sqrt(abs(evs))
s2=s1
for j=0,n1-1 do begin
s2(*,j)=s1(*,j)/(omg1[j]^2)
endfor
s01=s2
return,s01
end

