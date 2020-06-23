; =========================================================
; =======================================================
; calculate the lifetime distribution in single particle id series
; input, series, 0; time   1; type:(1,bcc solid 2, hcp solid  3, fcc solid  4, bcc precursor  5, hcp precursor  6, fcc precursor  7,8  liquid)
; we use an idcluster way to determine the consecutive type life time, just pickout the time with the certain type, and allocate (0,0,time) as their effective positions. 
; then do a cluster analysis to those 'particles', set 1.1 as dc, we can select out all the consecutive lifetime thing.  
pro lifetime1_solid,series,liqt = liqt, bcclt=bcclt,hcplt=hcplt,fcclt=fcclt,dc=dc
if not(keyword_set(dc)) then dc = 1.1
;liquid
wl=where(series(1,*) eq 8,nwl)
liqt=[-1.]
if nwl gt 0 then begin
  liq = series(*,wl)
  posl = fltarr(3,nwl)
  posl(2,*) = liq(0,*)   ;create the effective position,set the time as z 
  if nwl ge 5 then idcluster2,posl,c01,list=s01,deltar=dc else s01 = cluster4p(posl,deltar=dc)
  liqt=s01(0,*)
endif 
;bcc
wb=where(series(1,*) eq 1,nwb)
bcclt=[-1.]
if nwb gt 0 then begin
  bcc = series(*,wb)
  posb = fltarr(3,nwb)
  posb(2,*) = bcc(0,*)   ;create the effective position,set the time as z 
  if nwb ge 5 then idcluster2,posb,c01,list=s01,deltar=dc else s01 = cluster4p(posb,deltar=dc)
  bcclt=s01(0,*)
endif 
;hcp
wh=where(series(1,*) eq 2,nwh)
hcplt=[-1.]
if nwh gt 0 then begin
  hcp = series(*,wh)
  posh = fltarr(3,nwh)
  posh(2,*) = hcp(0,*)   ;create the effective position,set the time as z 
  if nwh ge 5 then idcluster2,posh,c01,list=s01,deltar=dc else s01 = cluster4p(posh,deltar=dc)
  hcplt=s01(0,*)
endif 
;fcc
wf=where(series(1,*) eq 3,nwf)
fcclt=[-1.]
if nwf gt 0 then begin
  fcc = series(*,wf)
  posf = fltarr(3,nwf)
  posf(2,*) = fcc(0,*)   ;create the effective position,set the time as z 
  if nwf ge 5 then idcluster2,posf,c01,list=s01,deltar=dc else s01 = cluster4p(posf,deltar=dc)
  fcclt=s01(0,*)
endif

end

;===============================================================================
pro lifetimeall_solid,dataall,idlist,liqta=liqta,bcclta=bcclta,hcplta=hcplta,fcclta=fcclta,dc=dc
liqta = [-1.]
bcclta= [-1.]
hcplta=[-1.]
fcclta=[-1.]
nid = n_elements(idlist(0,*))
for i = 0, nid -1 do begin
  if i mod 20 eq 0 then print,i
  w=where(dataall(16,*) eq idlist(i),nwi)
  if nwi lt 50 then continue
  seriesi = [dataall(15,w),dataall(17,w)]
  lifetime1_solid,seriesi,liqt = liqti, bcclt=bcclti,hcplt=hcplti,fcclt=fcclti,dc=dc
  liqta = [[liqta],[liqti]]
  bcclta= [[bcclta],[bcclti]]
  hcplta=[[hcplta],[hcplti]]
  fcclta=[[fcclta],[fcclti]]
endfor

liqta = liqta[where(liqta gt 0)]
bcclta = bcclta[where(bcclta gt 0)]
hcplta = hcplta[where(hcplta gt 0)]
fcclta = fcclta[where(fcclta gt 0)]
end


