; TANG, shixiang
; 26/2/2017
; calculate layer parameter on a single level
; usually we set cut-off eq to 0.4. if the layer parameter is less than 0.4, the particle is layered.
;--------------------------------------------------------------------------------------------------------

function cal_layer_parameter,bond,deltar1st=deltar1st,layerdistance=layerdistance,track=track
ncol=n_elements(bond[*,0])
npar=n_elements(bond[0,*])
if not keyword_set(deltar1st) then begin
 gr = ericgr3d(bond,rmin=1,rmax=10,deltar=0.1)
 deltar1st=firstfloor_search(gr)
endif
result=fltarr(ncol+1,npar)
result[ncol,*]=bond[ncol-1,*]
result[ncol-1,*]=bond[ncol-2,*]
result[0:ncol-3,*]=bond[0:ncol-3,*]
layercol=ncol-2
if keyword_set(track) then ncol=ncol-1
tlist = bond( ncol-1, uniq(bond(ncol-1,*)) )
ntlist = n_elements(tlist(*))
for i=0,ntlist-1 do begin
 wt=where(bond[ncol-1,*] eq tlist(i))
 if wt[0] eq -1 then continue
 message,'time='+string(i)+'             time from'+string(0)+'  to'+string(ntlist-1),/inf
 bondt=bond[*,wt]
 npar=n_elements(bondt[0,*])
 layer=fltarr(npar)
 for j=0L,npar-1 do begin
  dx=bondt(0,*)-bondt(0,j)
  dy=bondt(1,*)-bondt(1,j)
  dz=bondt(2,*)-bondt(2,j)
  w1w=where(abs(dx) le deltar1st and abs(dy) le deltar1st and abs(dz) le 1.2*layerdistance,nw1w)
  dx1=dx[0,w1w]
  dy1=dy[0,w1w]
  dz1=dz[0,w1w]
  array=dz1
  ;array=[0.01*dx1,0.01*dy1,dz1]
  ;weights=clust_wts(array,n_clusters=3,/double,n_iterations=1000)
  weights=[[-1*layerdistance],[0],[layerdistance]];;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  if n_elements(array) eq 1 then continue
  classify=cluster(array,weights,n_clusters=3)
  wlayer0=where(classify eq 0,n0)
  wlayer1=where(classify eq 1,n1)
  wlayer2=where(classify eq 2,n2)
  var=dblarr(3)
  if n0 gt 1 then begin 
   layer0=dz1[0,wlayer0]
   var[0]=stddev(layer0)
  endif 
 
  if n1 gt 1 then begin
   layer1=dz1[0,wlayer1]
   var[1]=stddev(layer1)
  endif
 
  if n2 gt 1 then begin
   layer2=dz1[0,wlayer2]
   var[2]=stddev(layer2)
  endif
  wvar=where(var gt 0)
  if wvar[0] eq -1 then continue
  varr=var[wvar] 
  layer[j]=mean(varr)
 endfor
 ;con=conlist(bondt,deltar=deltar1st,bondmax=40)
 ;layer_temp=layer
 ;for j=0L,npar-1 do begin
 ; w=where(layer_temp[con[j,1:con[j,0]]] lt 0.4,nc)
 ; layer[j]=float(nc)/con[j,0]
 ;endfor
 result[layercol,wt]=layer
endfor
return,result
end