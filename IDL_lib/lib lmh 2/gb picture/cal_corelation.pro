function cal_corelation,q1,q2
n=n_elements(q1[*,0])
qq1=complexarr(n)
qq2=complexarr(n)
for i=0,n-1 do begin
qq1[i]=mean(q1[i,*])
endfor
for i=0,n-1 do qq2[i]=mean(q2[i,*])
sum=0
for i=0,n-1 do begin
 sum+=qq1[i]*conj(qq2[i])
endfor
sum=real_part(sum)/(norm(qq1)*norm(qq2))
return,sum
end