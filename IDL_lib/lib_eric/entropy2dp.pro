function entropy2dp,data,rmin=rmin,rmax=rmax,deltar=deltar
tmin=min(data(5,*),max=tmax)
nr=(float(rmax)-float(rmin))/deltar+1
rvec=findgen(nr)*deltar+rmin
rsqr=rvec*rvec
result=fltarr(2,nr)
result(0,*)=rvec
rmin2=float(rmin)^2 & rmax2=float(rmax)^2
npts=n_elements(data(0,*))
density=npts/(1.0*(tmax-tmin+1.0))/(500.0*500.0)
message,'number density = '+string(density),/inf
wa=where(data(5,*) eq tmin,nwa)
resulta=fltarr(nr,nwa)
resultc=fltarr(5,nwa)
resultc(0:1,*)=data(0:1,wa)
for t=tmin,tmax do begin
 
  w=where(data(5,*) eq t,nw)
  tempresult=fltarr(nr,nw)
  
    for i=0L,nw-1L do begin
    one=fltarr(nw)+1.0
      pos0=data(0:1,w(i));      --> the reference point
      dd=one##pos0-data(0:1,w)
      w1a=where(dd(0,*) gt 250.0)
      if (w1a[0] ne -1) then begin
      dd(0,w1a)=dd(0,w1a)-500.0
      endif
      w1b=where(dd(0,*) lt -250.0)
      if (w1b[0] ne -1) then begin 
      dd(0,w1b)=dd(0,w1b)+500.0
      endif
      w1c=where(dd(1,*) gt 250.0)
      if (w1c[0] ne -1) then begin 
      dd(1,w1c)=dd(1,w1c)-500.0
      endif
      w1d=where(dd(1,*) lt -250.0)
      if (w1d[0] ne -1) then begin 
      dd(1,w1d)=dd(1,w1d)+500.0
      endif
      dis=total(dd*dd,1);       --> distance squared
      dis(i)=9e9
      w2=where(dis gt rmin2 and dis lt rmax2,nw2)
      if (nw2 gt 0) then begin
        newdis=sqrt(dis(w2));   --> distance
        thehisto=histogram(newdis,max=rmax,min=rmin,binsize=deltar)
       
          theta=2*3.14159265
       
          ; now need to set correction factor based on
          ; location of pos0 -- if it's near corners

        area=theta*rvec*deltar;   area of each ring
        w3=where(area lt 1e-9,nw3)
        if (nw3 gt 0) then area(w3)=9e9;  avoid divide-by-zero
        tempresult(*,i)=thehisto/area
      endif
    endfor; particle for-loop
    tempresult=tempresult/density
  
  resulta=resulta+tempresult
  if (t mod 5 eq 0) then begin
    ;plot,result(0,*),result(1,*)/(t-tmin+1.0)
    message,string(t)+"/"+string(tmax),/inf
  endif
endfor; time for-loop
for j=0,nw-1 do begin
ga=transpose(resulta(*,j))/(tmax-tmin+1.0)
w1=where(ga eq 0)
gb=(ga*alog(ga))*result(0,*)
gbb=(1.0-ga)*result(0,*)
gb[w1]=0.0
resultc(3,j)=-density*3.1416*integral(result(0,*),gb)
resultc(4,j)=-density*3.1416*integral(result(0,*),gbb)
resultc(2,j)=resultc(3,j)+resultc(4,j)
endfor
return,resultc
end

