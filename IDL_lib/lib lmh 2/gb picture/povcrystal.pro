;make pov file for crystal classification
pro povcrystal,bond,crystalclass,name=name,grainboundary=grainboundary,hgrainboundary=hgrainboundary, $
hcrystal=hcrystal,method=method
if keyword_set(hcrystal) then begin
 clusternum=max(crystalclass)
 npar=n_elements(bond[0,*])
 pos=bond[0:2,*]
 r=fltarr(1,npar)
 c=fltarr(4,npar)
 if keyword_set(grainboundary) then begin
  nboundary=n_elements(grainboundary[0,*])
  pos=fltarr(3,npar+nboundary)
  pos[*,0:npar-1]=bond[0:2,*]
  pos[*,npar:npar+nboundary-1]=grainboundary[0:2,*]
  r=fltarr(1,npar+nboundary)
  c=fltarr(4,npar+nboundary)
  r[0,npar:npar+nboundary-1]=0.4
  c[0,npar:npar+nboundary-1]=255./255
  c[1,npar:npar+nboundary-1]=0./255
  c[2,npar:npar+nboundary-1]=0./255
  c[3,npar:npar+nboundary-1]=0
 endif
 colorbase=fltarr(3,6)


 colorbase[0:2,3]=[127,0,255]
 colorbase[0:2,0]=[255,0,0]
 colorbase[0:2,2]=[0,200,0]
 colorbase[0:2,1]=[0,0,255]
 colorbase[0:2,4]=[255,88,10]
 colorbase[0:2,5]=[255,255,0]

 for i=1.,clusternum do begin 
  w=where(crystalclass eq i,ncluster)
  if ncluster eq 0 then continue
  ;pos[0:2,w]=bond[0:2,w]
  r[0,w]=0.1
  c[0,w]=colorbase[0,i-1]/255.
  c[1,w]=colorbase[1,i-1]/255.
  c[2,w]=colorbase[2,i-1]/255.
  c[3,w]=0.83
 endfor
endif

if keyword_set(hgrainboundary) then begin
 if method eq 1 then begin
 
  colorbase=fltarr(3,6)
  colorbase[0:2,3]=[0,204,0] ;green
  colorbase[0:2,0]=[153,76,0]  ;brown
  colorbase[0:2,2]=[0,0,153] ;dark blue
  colorbase[0:2,1]=[255,128,0] ;orange
  colorbase[0:2,4]=[0,255,255] ;light blue
  colorbase[0:2,5]=[204,255,204]
 
  npar=n_elements(bond[0,*])
  nboundary=n_elements(grainboundary[0,*])
  pos=fltarr(3,npar+nboundary)
  pos[*,0:npar-1]=bond[0:2,*]
  r=fltarr(1,npar+nboundary)+0.6
  c=fltarr(4,npar+nboundary)
  c[0,*]=colorbase[0,5]/255.
  c[1,*]=colorbase[1,5]/255.
  c[2,*]=colorbase[2,5]/255.
  c[3,*]=0.6
  pos[*,npar:npar+nboundary-1]=grainboundary[0:2,*]
  for i=1,4 do begin
   w=where((grainboundary[17,*] eq i) or (grainboundary[17,*] eq 10*i+1) or (grainboundary[17,*] eq 10*i+2) or (grainboundary[17,*] eq 10*i+3),nc)
   ww=w+npar
   if nc eq 0 then continue
   r[0,ww]=1.0
   c[0,ww]=colorbase[0,i-1]/255.
   c[1,ww]=colorbase[1,i-1]/255.
   c[2,ww]=colorbase[2,i-1]/255.
   c[3,ww]=0
  endfor
  ;w=where(grainboundary[17,*] eq 1,nc)
  ;ww=w+npar
  ;if nc ne 0 then begin
  ; r[0,ww]=1.0
  ; c[0,ww]=colorbase[0,0]/255.
  ; c[1,ww]=colorbase[1,0]/255.
  ; c[2,ww]=colorbase[2,0]/255. 
  ; c[3,ww]=0
  ;endif
 endif


 if method eq 2 then begin
 
  colorbase=fltarr(3,6)
  ;colorbase[0:2,3]=[127,0,255] ;purple
  ;colorbase[0:2,0]=[255,0,0]
  ;colorbase[0:2,2]=[0,200,0] ;green
  ;colorbase[0:2,1]=[0,0,255]
  ;colorbase[0:2,4]=[255,88,10]
  ;colorbase[0:2,5]=[255,255,0]
  colorbase[0:2,3]=[0,0,255] ;blue
  colorbase[0:2,0]=[139,0,0]  ;red
  colorbase[0:2,2]=[0,139,139] ;cyan
  colorbase[0:2,1]=[139,0,139] ;purple
  colorbase[0:2,4]=[0,255,0] ;green
  colorbase[0:2,5]=[204,255,204] 
  
  npar=n_elements(bond[0,*])
  nboundary=n_elements(grainboundary[0,*])
  pos=fltarr(3,npar+nboundary)
  pos[*,0:npar-1]=bond[0:2,*]
  r=fltarr(1,npar+nboundary)+0.6
  c=fltarr(4,npar+nboundary)
  c[0,*]=colorbase[0,5]/255.
  c[1,*]=colorbase[1,5]/255.
  c[2,*]=colorbase[2,5]/255.
  c[3,*]=0.6
  pos[*,npar:npar+nboundary-1]=grainboundary[0:2,*]
  
  w=where((grainboundary[17,*] eq 11) or (grainboundary[17,*] eq 21),nc)
  ww=w+npar
  if nc gt 0 then begin
  r[0,ww]=1.0
  c[0,ww]=colorbase[0,0]/255.
  c[1,ww]=colorbase[1,0]/255.
  c[2,ww]=colorbase[2,0]/255.
  c[3,ww]=0
  endif
  
  w=where((grainboundary[17,*] eq 12) or (grainboundary[17,*] eq 22),nc)
  ww=w+npar
  if nc gt 0 then begin
  r[0,ww]=1.0
  c[0,ww]=colorbase[0,1]/255.
  c[1,ww]=colorbase[1,1]/255.
  c[2,ww]=colorbase[2,1]/255.
  c[3,ww]=0
  endif
 
  w=where((grainboundary[17,*] eq 13) or (grainboundary[17,*] eq 23),nc)
  ww=w+npar
  if nc gt 0 then begin 
  r[0,ww]=1.0
  c[0,ww]=colorbase[0,2]/255.
  c[1,ww]=colorbase[1,2]/255.
  c[2,ww]=colorbase[2,2]/255.
  c[3,ww]=0
  endif
 
  w=where(grainboundary[17,*] eq 3,nc)
  ww=w+npar
  if nc gt 0 then begin
  r[0,ww]=1.0
  c[0,ww]=colorbase[0,3]/255.
  c[1,ww]=colorbase[1,3]/255.
  c[2,ww]=colorbase[2,3]/255.
  c[3,ww]=0
  endif
  
  w=where(grainboundary[17,*] eq 4,nc)   
  ww=w+npar
  if nc gt 0 then begin
   r[0,ww]=1.0
   c[0,ww]=colorbase[0,4]/255.
   c[1,ww]=colorbase[1,4]/255.
   c[2,ww]=colorbase[2,4]/255. 
   c[3,ww]=0
  endif
 endif 
endif

mkpov,pos,name,radius=r,color=c,margin=8

end