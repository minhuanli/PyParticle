;evsnew is correlated values, data is fitted value
pro ntcorrelate,evs,n0,evsnew,data
n1=n_elements(evs(0,*))
e02=fltarr(2,n1-1)
e03=evs
for j=0,n1-2 do begin
r01=linfit(evs(0:n0-1,0),evs(0:n0-1,j+1),yfit=y1)
e02(0,j)=r01[0]
e02(1,j)=r01[1]
e03(0:n0-1,j+1)=y1
endfor
evsnew=e02
data=e03
end