function esitmate_epsilon,prj,k
m=n_elements(prj[0,*])
n=n_elements(prj[0:2,0])
Eps=((product(max(prj[0:2,*],dimension=2)-min(prj[0:2,*],dimension=2))*k*gamma(.5*n+1))/(m*sqrt(!pi^n)))^(1./n); 
return,eps 
end

; result : 0 x , 1 y , 2 z , 3 average length, 4 patch deviation on sphere
function lat,prj_temp,neighbornum=neighbornum,k=k,density_based=density_based,class=class
 prj=prj_temp
 if keyword_set(density_based) then begin
  if not keyword_set(k) then k=20
  npar=n_elements(prj[0,*])
  nei=fltarr(npar)
  radius=esitmate_epsilon(prj,k)
  for i=0L,npar-1 do begin
   dis=(prj[0,*]-prj[0,i])^2+(prj[1,*]-prj[1,i])^2+(prj[2,*]-prj[2,i])^2
   es=where(dis le radius,nnn)
   nei[i]=nnn
  endfor
  w=where(nei gt k)
  prj=prj[*,w]
 endif 
 weights=CLUST_WTS(prj[0:2,*], N_CLUSTERS = neighbornum, n_iteration=100) 
 class = CLUSTER(prj_temp[0:2,*], weights, N_CLUSTERS = neighbornum)
 result=fltarr(6,neighbornum)
 result[0:2,*]=weights
 patchavg=fltarr(2)
 for i=0,neighbornum-1 do begin
  w=where(class eq i,nw)
  result[3,i]=mean(prj[3,w])
  temp=cv_coord(from_rect=prj(0:2,w),/to_sphere)
  patchavg(0)=mean(temp[0,*])  ; average cita angle
  patchavg(1)=mean(temp[1,*])  ; average phi angle
  temp(0,*) = temp(0,*)-patchavg(0)
  temp(1,*) = temp(1,*)-patchavg(1)   ; distance from average cita phi
  varia = temp(0,*)^2+temp(1,*)^2
  result(4,i) = sqrt(total(varia,2)/(float(nw)*float(nw-1.)))
  result(5,i) = float(nw) / float(npar)
  result[0:2,i]=result[3,i]*result[0:2,i]/norm(result[0:2,i])
 endfor 
 ;write_text,prj,'try.txt'
 return,result
end