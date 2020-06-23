; entropy2d      two point excess correlation entropy of each particle 

function checkquadrant,pos0,xref,yref,hix=hix,hiy=hiy, $
      nr,rvec,rsqr,rmax,thetax=thetax,thetay=thetay



rvec2=rvec > 0.001; ---> to avoid divide-by-zero errors

if (not keyword_set(thetax)) then begin
  if (keyword_set(hix)) then begin
    if ((xref-rmax) gt pos0(0)) then begin
      thetax=fltarr(nr);    --> zero!
    endif else begin
      xprime=(abs(fltarr(nr)+xref-pos0(0))) < rvec
      thetax=acos(xprime/rvec2)
    endelse
  endif else begin
    if ((xref+rmax) lt pos0(0)) then begin
      thetax=fltarr(nr);    --> zero!
    endif else begin
      xprime=abs(fltarr(nr)+pos0(0)-xref) < rvec
      thetax=acos(xprime/rvec2)
    endelse
  endelse
endif

if (not keyword_set(thetay)) then begin
  if (keyword_set(hiy)) then begin
    if ((yref-rmax) gt pos0(1)) then begin
      thetay=fltarr(nr);    --> zero!
    endif else begin
      yprime=abs(fltarr(nr)+yref-pos0(1)) < rvec
      thetay=acos(yprime/rvec2)
    endelse
  endif else begin
    if (yref+rmax lt pos0(1)) then begin
      thetay=fltarr(nr);    --> zero!
    endif else begin
      yprime=abs(fltarr(nr)+pos0(1)-yref) < rvec
      thetay=acos(yprime/rvec2)
    endelse
  endelse
endif

theta=(fltarr(nr)+3.14159265*0.5)-thetax-thetay
dcorner=pos0-[xref,yref]
cornerdist=total(dcorner*dcorner)
w=where(rsqr ge cornerdist,nw)
if (nw gt 0) then theta(w)=0.0
return,theta
end
;------------------------------------------------------------

function entropy2dgr,data,rmin=rmin,rmax=rmax,deltar=deltar,track=track
; assumes pretrack data unless /track is used

if (not keyword_set(rmin)) then rmin=0.0
if (not keyword_set(rmax)) then rmax=10.0
if (not keyword_set(deltar)) then deltar=0.01
nel=n_elements(data(*,0));   how many columns in data array
npts=n_elements(data(0,*));  how many particles total
tel=nel-1
if (keyword_set(track)) then tel=nel-2

tmin=min(data(tel,*),max=tmax)
nr=(float(rmax)-float(rmin))/deltar+1
rvec=findgen(nr)*deltar+rmin
rsqr=rvec*rvec
result=fltarr(2,nr)
result(0,*)=rvec
rmin2=float(rmin)^2 & rmax2=float(rmax)^2
x0=min(data(0,*),max=x1);  boundaries of system
y0=min(data(1,*),max=y1)
density=npts/(1.0*(tmax-tmin+1.0))/((x1-x0)*(y1-y0))
message,'number density = '+string(density),/inf
wa=where(data(5,*) eq 0,nwa)
resulta=fltarr(nr,nwa)
resultc=fltarr(3,nwa)
resultc(0:1,*)=data(0:1,wa)

for t=tmin,tmax do begin
 
  w=where(data(tel,*) eq t,nw)
  tempresult=fltarr(nr,nw)
  if (nw gt 0) then begin
    one=fltarr(nw)+1.0
    w4=where((x0+rmax lt data(0,w)) and (data(0,w) lt x1-rmax) and $
                    (y0+rmax lt data(1,w)) and (data(1,w) lt y1-rmax),nw4)
    flag=one
    if (nw4 gt 0) then flag(w4)=0.0
    for i=0L,nw-1L do begin
      pos0=data(0:1,w(i));      --> the reference point
      dd=one##pos0-data(0:1,w)
      dis=total(dd*dd,1);       --> distance squared
      dis(i)=9e9
      w2=where(dis gt rmin2 and dis lt rmax2,nw2)
      if (nw2 gt 0) then begin
        newdis=sqrt(dis(w2));   --> distance
        thehisto=histogram(newdis,max=rmax,min=rmin,binsize=deltar)
        if (flag(i) lt 0.5) then begin
          ; it's far from the edges
          theta=2*3.14159265
        endif else begin
          ; now need to set correction factor based on
          ; location of pos0 -- if it's near corners
          ; check all four quadrants:
          tx=0 & ty=0 & tx2=0 & ty2=0
theta1=checkquadrant(pos0,x0,y0,nr,rvec,rsqr,rmax,thetax=tx,thetay=ty)
theta2=checkquadrant(pos0,x1,y0,nr,rvec,rsqr,rmax,/hix,thetax=tx2,thetay=ty)
theta3=checkquadrant(pos0,x1,y1,nr,rvec,rsqr,rmax,/hix,/hiy, $
      thetax=tx2,thetay=ty2)
theta4=checkquadrant(pos0,x0,y1,nr,rvec,rsqr,rmax,/hiy,thetax=tx,thetay=ty2)
          theta=theta1+theta2+theta3+theta4
        endelse
        area=theta*rvec*deltar;   area of each ring
        w3=where(area lt 1e-9,nw3)
        if (nw3 gt 0) then area(w3)=9e9;  avoid divide-by-zero
        tempresult(*,i)=thehisto/area
      endif
    endfor; particle for-loop
    tempresult=tempresult/density
  endif
  resulta=resulta+tempresult
  if (t mod 5 eq 0) then begin
    ;plot,result(0,*),result(1,*)/(t-tmin+1.0)
    message,string(t)+"/"+string(tmax),/inf
  endif
endfor; time for-loop
for j=0,nw-1 do begin
ga=transpose(resulta(*,j))/(tmax-tmin+1.0)
w1=where(ga eq 0)
gb=(ga*alog(ga)-ga+1)*result(0,*)
gb[w1]=0.0
resultc(2,j)=-density*3.1416*integral(result(0,*),gb)
endfor
resultabc=fltarr(nr,nwa+1)
resultabc(*,0)=rvec
resultabc(*,1:nwa)=resulta/(tmax-tmin+1.0)
return,resultabc
end

