function seqchange,data,t=t
if (keyword_set(t)) then t=t else t=1
n=n_elements(data(0,*))
temp=fltarr(16,n)
temp(0:2,*)=data(9:11,*)
temp(3,*)=data(0,*)
temp(4:11,*)=data(1:8,*)
temp(14,*)=data(12,*)
temp(15,*)=t
return,temp
end