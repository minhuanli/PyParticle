pro dispersionrelation,ftr,flo,evs,dtr,dlo,str,slo,bins=bins
n1=n_elements(evs)
omg1=1./sqrt(abs(evs))
d01=histogram(omg1,binsize=bins,locations=loc)
n2=n_elements(loc)
d01=fltarr(64,n2-1)
d02=fltarr(64,n2-1)
str=fltarr(64,n2-1)
slo=fltarr(64,n2-1)
for j=0,n2-2 do begin
w=where(omg1 ge loc[j] and omg1 lt loc[j+1])
if (w[0] ne -1) then begin
n3=n_elements(w)
a1=rebin(ftr(*,w),64,1)
a01=rebin(flo(*,w),64,1)
d01(*,j)=a1
d02(*,j)=a01
endif
endfor
dtr=d01
dlo=d02
q1=findgen(64)+1.0
w1=(findgen(n2-1)+1.0)
for l=0,63 do begin
str(l,*)=d01(l,*)*(q1[l]^2)
slo(l,*)=d02(l,*)*(q1[l]^2)
endfor
for m=0,n2-2 do begin
str(*,m)=str(*,m)*d01[m]/(w1[m]^2)
slo(*,m)=slo(*,m)*d01[m]/(w1[m]^2)
endfor
end