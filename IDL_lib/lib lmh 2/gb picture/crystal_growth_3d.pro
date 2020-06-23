function cal_corelation,q1,q2
n=n_elements(q1[*,0])
qq1=complexarr(n)
qq2=complexarr(n)
for i=0,n-1 do begin
qq1[i]=mean(q1[i,*])
endfor
for i=0,n-1 do qq2[i]=mean(q2[i,*])
sum=0
for i=0,n-1 do begin
 sum+=qq1[i]*conj(qq2[i])
endfor
sum=real_part(sum)/(norm(qq1)*norm(qq2))
return,sum
end



function grow_clustershell,clusterorigin,conl=conl,clusterid=clusterid
 w=where(clusterorigin eq clusterid,npar)
 ww=w
 for i=0L,npar-1 do begin
  neigh=conl[w[i],1:conl[w[i],0]]
  ww=setunion(ww,transpose(neigh))
 endfor
 return,setdifference(ww,w)
end


pro single_clustergrowth,clusterorigin,forbiddenarea=forbiddenarea,q6colation=q6colation,clusterq6=clusterq6,$
         conl=conl,q6origin=q6origin,clusterid=clusterid,trb=trb,search_time=search_time,time=time

 clustershellaftergrow=grow_clustershell(clusterorigin,clusterid=clusterid,conl=conl)
 w=where(forbiddenarea[clustershellaftergrow,clusterid-1] eq 1)
 clustershell=setdifference(clustershellaftergrow,w)
 nshell=n_elements(clustershell)
 for i=0L,nshell-1 do begin
  ;if clustershell[i] eq 51281 then begin
  ; print,51281
  ;endif
  if ((cal_corelation(q6origin[*,clustershell[i]],clusterq6) gt q6colation[clustershell[i]]) and $
  (q6colation[clustershell[i]] gt -90) and (cal_corelation(q6origin[*,clustershell[i]],clusterq6) gt 0.7) and ((trb[16,clustershell[i]]-trb[3,clustershell[i]]) gt 1) and (search_time[clustershell[i]] lt time)) $
  or (q6colation[clustershell[i]] le -90) or ((cal_corelation(q6origin[*,clustershell[i]],clusterq6) gt q6colation[clustershell[i]]) and ((trb[16,clustershell[i]]-trb[3,clustershell[i]]) gt 1) and $
  search_time[clustershell[i]] eq time) then begin
   q6colation[clustershell[i]]=cal_corelation(q6origin[*,clustershell[i]],clusterq6)
   clusterorigin[clustershell[i]]=clusterid
   search_time[clustershell[i]]=time
  endif else begin
   forbiddenarea[clustershell[i],clusterid-1]=1
  endelse
 endfor
 w=where(clusterorigin eq clusterid)
 ;clusterq6[0]=mean(q6origin[0,w])
 ;clusterq6[1]=mean(q6origin[1,w])
 ;clusterq6[2]=mean(q6origin[2,w])
 ;clusterq6[3]=mean(q6origin[3,w])
 ;clusterq6[4]=mean(q6origin[4,w])
 ;clusterq6[5]=mean(q6origin[5,w])
 ;clusterq6[6]=mean(q6origin[6,w])
 ;clusterq6[7]=mean(q6origin[7,w])
 ;clusterq6[8]=mean(q6origin[8,w])
 ;clusterq6[9]=mean(q6origin[9,w])
 ;clusterq6[10]=mean(q6origin[10,w])
 ;clusterq6[11]=mean(q6origin[11,w])
 ;clusterq6[12]=mean(q6origin[12,w])
end





function createforbiddenarea,clusterorigin
 nparticle=n_elements(clusterorigin)
 ncluster=max(clusterorigin)
 forbidden=fltarr(nparticle,ncluster)
 for i=1,ncluster do begin
  w=where(clusterorigin gt 0 and clusterorigin ne i)
  forbidden[w,i-1]=1
 endfor
 return,forbidden
end

function createclusterq6,clusterorigin,qq6m
 ncluster=max(clusterorigin)
 nparticle=n_elements(nparticle)
 clusterq6=complexarr(13,ncluster)
 for i=0,ncluster-1 do begin
  w=where(clusterorigin eq i+1)
  clusterq6[0,i]=mean(qq6m[0,w])
  clusterq6[1,i]=mean(qq6m[1,w])
  clusterq6[2,i]=mean(qq6m[2,w])
  clusterq6[3,i]=mean(qq6m[3,w])
  clusterq6[4,i]=mean(qq6m[4,w])
  clusterq6[5,i]=mean(qq6m[5,w])
  clusterq6[6,i]=mean(qq6m[6,w])
  clusterq6[7,i]=mean(qq6m[7,w])
  clusterq6[8,i]=mean(qq6m[8,w])
  clusterq6[9,i]=mean(qq6m[9,w])
  clusterq6[10,i]=mean(qq6m[10,w])
  clusterq6[11,i]=mean(qq6m[11,w])
  clusterq6[12,i]=mean(qq6m[12,w])
 endfor
 return,clusterq6
end

pro plot_process,trb,clusterorigin,noplot=noplot
clusternum=max(clusterorigin)
if not keyword_set(noplot) then window,/free
w=where(clusterorigin ne 0)
if not keyword_set(noplot) then plot,trb[0,w],trb[1,w],psym=3
if not keyword_set(noplot) then color1=[10000000,1000,50000,100000,100000]
if not keyword_set(noplot) then sym=[3,3,3,3,6]
for i=1.,clusternum do begin
 w=where(clusterorigin eq i)
 if not keyword_set(noplot) then oplot,trb[0,w],trb[1,w],psym=sym[i-1],color=color1[i-1]
 print,n_elements(w)
endfor
end



function crystal_growth_3d,clusterorigin,qq6m,conl=conl,trb=trb,deltar=deltar,noplot=noplot,q6colation=q6colation
 clusterorigin1=clusterorigin
 if (keyword_set(conl)) then conl=conl else conl=conlist(trb,deltar=deltar,bondmax=20)
 forbidden=createforbiddenarea(clusterorigin1)
 ncluster=max(clusterorigin1)
 nparticle=n_elements(clusterorigin1)
 classparticlenum=where(clusterorigin1 gt 0,nc)
 classparticlenum=nc
 classparticlenum2=nc
 q6colation=fltarr(nparticle)-99.
 wpp=where(clusterorigin1 gt 0)
 q6colation[wpp]=1.5
 ;print,'q6:',q6colation[51281]
 ;print,clusterorigin1[51281]
 clusterq6_1=createclusterq6(clusterorigin1,qq6m)
 clusterq6_2=clusterq6_1
 clusterq6test2=clusterorigin1
 forbiddenarea=forbidden
 time=0
 search_time=fltarr(nparticle)
 repeat begin
  time++
  clusterq6test1=clusterq6test2
  for i=0,ncluster-1 do begin
   single_clustergrowth,clusterorigin1,forbiddenarea=forbiddenarea,q6colation=q6colation,clusterq6=clusterq6_1[*,i],$
   conl=conl,q6origin=qq6m,clusterid=i+1,trb=trb,search_time=search_time,time=time
   clusterq6_1=clusterq6_2
  endfor
  clusterq6test2=clusterorigin1
  print,'eq?',total(clusterq6test2 ne clusterq6test1)
  ;if keyword_set(noplot) then plot_process,trb,clusterorigin1,/noplot else plot_process,trb,clusterorigin1
  ;print,'q6:',q6colation[51281]
  ;print,clusterorigin1[51281]
 endrep until (total(clusterq6test2 ne clusterq6test1) eq 0)
 return,clusterorigin1
end