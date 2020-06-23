function spacorr_sta,correlation=correlation,bin=bin

rmax = max(correlation(0,*))
rmin = min(correlation(0,*))
n2=(rmax-rmin)/bin
rvec=findgen(n2)*bin+rmin
res =fltarr(2,n2)
for i = 0.,n2-1 do begin
   w=where(correlation(0,*) ge rvec(i) and correlation(0,*) lt rvec(i)+bin,nw)
   if nw eq 0 then continue
   res(0,i) = rvec(i)
   res(1,i) = mean(correlation(1,w))
endfor

return,res

end 