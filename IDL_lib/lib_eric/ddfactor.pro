pro ddfactor, omg1,ftr,ffo,dd1,dd2,bins=bins
h01=histogram(omg1,location=loc,binsize=bins)
n1=n_elements(loc)
w1=where(h01 ne 0)
loc=loc[w1]
n2=n_elements(w1)
dd1=findgen(64,n2-1)
dd2=findgen(64,n2-1)
for j=0,n2-2 do begin
w=where(omg1 ge loc[j] and omg1 lt loc[j]+bins,ncount)
k1=rebin(ftr(*,w),64,1)
k2=rebin(ffo(*,w),64,1)
dd1(*,j)=k1
dd2(*,j)=k2
endfor
end
