;========================================================================================================================
; this program identifies the crystal nuclei!
pro idnuclei3,data,data2,list=list,deltar=deltar,conl=conl,looptime=looptime,bondorder_threshold=bondorder_threshold
 if not keyword_set(looptime) then looptime=3
 if not keyword_set(bondorder_threshold) then bondorder_threshold=7
 n1=n_elements(data(0,*))
 ;dm1=conlist(data,deltar=deltar,bondmax=20);
 if (keyword_set(conl)) then dm1=conl else dm1=conlist(data,deltar=deltar,bondmax=20)
 
 for i=0,looptime do begin
 w=where(dm1[*,0] le bondorder_threshold,nw)
  for j=0L,nw-1 do begin
   if dm1[w[j],0] le 0 then continue
   dm1[dm1[w[j],1:dm1[w[j],0]],0]=dm1[dm1[w[j],1:dm1[w[j],0]],0]-1
   ;ww=where(dm1[dm1[w,1:dm1[w,0]],0])
   dm1[w[j],*]=0
  endfor
 endfor
 
 
 idd=make_array(n1+1,/float,value=-1)
 data1=fltarr(n1)
 indice=0
 visited=fltarr(n1)
 for i=0.,n1-1 do begin
  if idd[i] eq -1 then begin
   indice=indice+1L
   ;nearby,dm1,i,indice=indice,idd=idd
   head1=0L
   tail1=0L
   visited[tail1]=i
   idd[i]=indice
   while head1 ge tail1 do begin
    for j=1,dm1[visited[tail1],0] do begin
     if idd[dm1[visited[tail1],j]] eq -1 then begin
      idd[dm1[visited[tail1],j]]=indice
      head1=head1+1
      visited[head1]=dm1[visited[tail1],j]
     endif
    endfor
    tail1=tail1+1
   endwhile
  endif 
 endfor
 data2=fltarr(n1)
 list=fltarr(4,1)
 kk=0
 for i=1.,indice do begin
  w=where(idd eq i,nc)
  if nc le 50 then continue
  kk++
  data2[w]=kk
  list1=fltarr(4,1)
  list1[0]=nc
  ;data2[i-1,w]=1
  list1[1]=mean(data(0,w))
  list1[2]=mean(data(1,w))
  list1[3]=mean(data(2,w))
  list=[[list],[list1]]
 endfor
  data2=transpose(data2)
  nlist=n_elements(list(0,*))
  list=list(*,1:(nlist-1))
end

;=========================================================================================================================
;1,bcc,2,fcc+hcp,3,fcc,4,hcp,5,mrco,6,bcc mrco,7,fcc mrco,8 hcp mrco,precursors are defined as low bond number and high Q6
function fccboo3dnew_revised1,boo,abcc=abcc,bfcc=bfcc,chcp=chcp,dbccmicro=dbccmicro,efccmicro=efccmicro,fhcpmicro=fhcpmicro
n1=max(boo(17,*))-min(boo(17,*))
f01=fltarr(11,n1+1)
abcc=make_array(300000,n1+1,/long,value=-1)
bfcc=make_array(200000,n1+1,/long,value=-1)
chcp=make_array(200000,n1+1,/long,value=-1)
dbccmicro=make_array(300000,/long,n1+1,value=-1)
efccmicro=make_array(200000,/long,n1+1,value=-1)
fhcpmicro=make_array(200000,/long,n1+1,value=-1)
;nuclei=make_array(100000,n1+1,value=-1)
;micro=make_array(100000,n1+1,value=-1)
ta=min(boo(17,*))+findgen(n1+1)
f01(0,*)=ta
print,'1,bcc,2,fcc+hcp,3,fcc,4,hcp,5,mrco,6,bcc mrco,7,fcc mrco,8 hcpmrco,9 solid percentage,10 pure liq, n_stk=',n1
for j=0,n1 do begin
;print,j
w=where(boo(17,*) eq ta[j],nbb)
;b01=boo(*,w)
w1=where(boo(17,*) eq ta[j] and boo(3,*) gt 7,naa)
www1=where(boo(17,*) eq ta[j] and boo(3,*) gt 7,nnaa)
if naa gt 0 then begin
;b001=b01(*,w1)
;w11=where(b001(14,*) gt 13, na)
w11=where(boo(17,*) eq ta[j] and boo(3,*) gt 7 and boo[16,*] gt 13, na)
abcc[0:na-1,j]=w11
w12=where(boo(17,*) eq ta[j] and boo(3,*) gt 7 and boo[16,*] lt 13, nb)
if nb gt 0 then begin
;b002=b001(*,w12)
;b0x=b002(8,*)-0.1275
;b0y=b002(10,*)+0.2
b0x=boo[10,*]-0.12
b0y=boo[13,*]+0.2
b0z=b0y/b0x
w13=where(boo[17,*] eq ta[j] and boo(3,*) gt 7 and boo[16,*] lt 13 and b0x gt 0 and b0z lt 0.4/0.13,nc)
bfcc[0:nc-1,j]=w13
;w133=where(b0x ne b0x[w13],ndd)
w133=subset(w12,w13,setnumber=ndd)
chcp[0:ndd-1,j]=w133
nd=nb-nc
endif else begin
nc=0
nd=0
endelse
;w14=where(b01(3,*) le 7.0 and b01(5,*) gt 0.27 and b01(14,*) gt 11, ncc);;;;
;w15=where(b01(3,*) le 7.0 and b01(5,*) gt 0.27 and b01(14,*) gt 13, ncc1);;;;;
w14=where(boo[17,*] eq ta[j] and boo[3,*] le 7.0 and boo[5,*] gt 0.27, ncc)
w15=where(boo[17,*] eq ta[j] and boo[3,*] le 7.0 and boo[5,*] gt 0.27 and boo[16,*] gt 13, ncc1)
if ncc1 ne 0 then dbccmicro[0:ncc1-1,j]=w15
w16=where(boo[17,*] eq ta[j] and boo(3,*) le 7.0 and boo(5,*) gt 0.27 and boo(16,*) lt 13 , ncc2);;;;
if ncc2 gt 0 then begin
;c002=b01(*,w16)
;b00x=c002(8,*)-0.1275  18
;b00y=c002(10,*)+0.2
b00x=boo(10,*)-0.12
b00y=boo(13,*)+0.2
b00z=b00y/b00x
;w17=where(b00x gt 0 and b00z lt 0.4/0.1225,ncc3)
w17=where(boo[17,*] eq ta[j] and boo[3,*] le 7.0 and boo[5,*] gt 0.27 and boo[16,*] lt 13 and b00x gt 0 and b0z lt 0.4/0.13,ncc3)
efccmicro[0:ncc3-1,j]=w17
;w177=where(b00x ne b0x[w17],nccc3)
w177=subset(w16,w17,setnumber=nccc3)
fhcpmicro[0:nccc3-1,j]=w177
ncc4=ncc2-ncc3
endif else begin
ncc3=0
ncc4=0
endelse
f01(1,j)=1.0*na/naa
f01(2,j)=1.0*nb/naa
f01(3,j)=1.0*nc/naa
f01(4,j)=1.0*nd/naa
f01(5,j)=1.0*ncc/nbb  
f01(6,j)=1.0*ncc1/ncc
f01(7,j)=1.0*ncc3/ncc
f01(8,j)=1.0*ncc4/ncc
f01(9,j)=1.0*nnaa/nbb
f01(10,j)=1.0-f01(9,j)-f01(5,j)
endif
endfor
return,f01
end

;======================================================================================
;==================================================================================
function cal_self_correlation,bond1,bond2
n=n_elements(bond1[0,*])
n1=n_elements(bond1[*,0])
nn=n_elements(bond2[0,*])
nn1=n_elements(bond2[*,0])
result=fltarr(n,nn)
for i=0.,n-1 do begin
 for j=0.,nn-1 do begin
  result[i,j]=cal_corelation(bond1[3:n1-1,i],bond2[3:nn1-1,j])
 endfor
endfor
return,result
end

;====================================================================================
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
;-------------------------------------------------------------------
;-----------------------------------------------------------------------------------
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

;---------------------------------------------------------------
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
;------------------------------------------------------------------------------------
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
;-----------------------------------------------------------------------------------
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

;----------------------------------------------------------------------------------------------
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
  if keyword_set(noplot) then plot_process,trb,clusterorigin1,/noplot else plot_process,trb,clusterorigin1
  ;print,'q6:',q6colation[51281]
  ;print,clusterorigin1[51281]
 endrep until (total(clusterq6test2 ne clusterq6test1) eq 0)
 return,clusterorigin1
end

;=================================================================
;===============================================================
function cal_bondorder,qq6m,neigh,i,dc=dc
if (not keyword_set(dc)) then dc=0.7
q6m1=sqrt(total((abs(qq6m[*,i]))^2))
q6mw=sqrt(total((abs(qq6m[*,neigh[1:neigh[0]]]))^2,1))  
w1=neigh[1:neigh[0]]
nn = n_elements(qq6m(*,0))
qiqj01 = 0.
for k = 0,nn-1 do begin
  qiqj01 = qiqj01 + (qq6m(k,i)*conj(qq6m(k,w1)))
endfor
;qiqj01=(qq6m(0,i)*conj(qq6m(0,w1)))+(qq6m(1,i)*conj(qq6m(1,w1)))+(qq6m(2,i)*conj(qq6m(2,w1)))$
;+(qq6m(3,i)*conj(qq6m(3,w1)))+(qq6m(4,i)*conj(qq6m(4,w1)))+(qq6m(5,i)*conj(qq6m(5,w1)))+$
;(qq6m(6,i)*conj(qq6m(6,w1)))+(qq6m(7,i)*conj(qq6m(7,w1)))+(qq6m(8,i)*conj(qq6m(8,w1)))+$
;(qq6m(9,i)*conj(qq6m(9,w1)))+(qq6m(10,i)*conj(qq6m(10,w1)))+(qq6m(11,i)*(qq6m(11,w1)))+$
;(qq6m(12,i)*conj(qq6m(12,w1)))
qiqj02=real_part(qiqj01)/(q6m1*q6mw)
ww=where(qiqj02[0,*] gt dc,nsolid)
return,nsolid
end
;-----------------------------------------------------------------------------
function search_second_neigh,bond,deltar=deltar,length=length,qq6m=qq6m,bondorder=bondorder,cutoff=cutoff
particlenum=n_elements(bond[0,*])
result=fltarr(501,particlenum)
bondorder=fltarr(particlenum)
for i=0L,particlenum-1 do begin
 dx=bond[0,*]-bond[0,i]
 dy=bond[1,*]-bond[1,i]
 dz=bond[2,*]-bond[2,i]
 dr=dx^2+dy^2+dz^2
 w=where(dr le length^2 and dr gt deltar^2,nw)
 result[0,i]=nw
 result[1:nw,i]=w
 bondorder[i]=cal_bondorder(qq6m,result[*,i],i,dc=cutoff)/float(nw)
endfor
return,result
end

;=========================================================================
;==========================================================================
function grow_clustershell,clusterorigin,conl=conl,clusterid=clusterid
 w=where(clusterorigin eq clusterid,npar)
 ww=w
 for i=0L,npar-1 do begin
  neigh=conl[w[i],1:conl[w[i],0]]
  ww=setunion(ww,transpose(neigh))
 endfor
 return,setdifference(ww,w)
end

;==========================================================================================
;==========================================================================================
pro idcluster33,data,data2,list=list,deltar=deltar,conl=conl
 n1=n_elements(data(0,*))
 ;dm1=conlist(data,deltar=deltar,bondmax=20);
 if (keyword_set(conl)) then dm1=conl else dm1=conlist(data,deltar=deltar,bondmax=20)
 
 idd=make_array(n1+1,/float,value=-1)
 data1=fltarr(n1)
 indice=0
 visited=fltarr(n1)
 for i=0.,n1-1 do begin
  if idd[i] eq -1 then begin
   indice=indice+1L
   ;nearby,dm1,i,indice=indice,idd=idd
   head1=0L
   tail1=0L
   visited[tail1]=i
   idd[i]=indice
   while head1 ge tail1 do begin
    for j=1,dm1[visited[tail1],0] do begin
     if idd[dm1[visited[tail1],j]] eq -1 then begin
      idd[dm1[visited[tail1],j]]=indice
      head1=head1+1
      visited[head1]=dm1[visited[tail1],j]
     endif
    endfor
    tail1=tail1+1
   endwhile
  endif 
 endfor
 data2=fltarr(n1)
 list=fltarr(4,1)
 kk=0
 for i=1.,indice do begin
  w=where(idd eq i,nc)
  ;if nc le 50 then continue
  kk++
  data2[w]=kk
  list1=fltarr(4,1)
  list1[0]=nc
  ;data2[i-1,w]=1
  list1[1]=mean(data(0,w))
  list1[2]=mean(data(1,w))
  list1[3]=mean(data(2,w))
  list=[[list],[list1]]
 endfor
  data2=transpose(data2)
  nlist=n_elements(list(0,*))
  list=list(*,1:(nlist-1))
end

;----------------------------------------------------------------------------------------------------------
;==========================================================================================================
function search_grain_boundary,bond,class,conl=conl,whereflag=whereflag,deltar=deltar,with_defects=with_defects
 if (keyword_set(conl)) then conl=conl else conl=conlist(bond,deltar=deltar,bondmax=20)
 npar=n_elements(bond[0,*])
 result=[-1]
 for i=0.,npar-1 do begin
  otherclass=0
  for j=1,conl[i,0] do begin
   if (class[i] ne class[conl[i,j]]) and (class[i] ne 0) and (class[conl[i,j]] ne 0) then otherclass++
  endfor
   if (float(otherclass)/conl[i,0]) gt 0.1 then result=setunion(result,i) 
 endfor
 if keyword_set(with_defects) then begin
  wdefect=where(bond[3,*] le 7)
  idcluster33,bond[*,wdefect],data,list=list,deltar=deltar
  datadefect=fltarr(n_elements(bond[0,*]))
  datadefect[wdefect]=data
  clusternum=max(datadefect)
  neiclunum=max(class)
  for i=1.,clusternum do begin
   shellid=grow_clustershell(datadefect,conl=conl,clusterid=i)
   clustersta=fltarr(neiclunum+1)
   for j=0,n_elements(shellid)-1 do begin
    clustersta[class[shellid[j]]]++
   end
   neighborcluster=where(clustersta ne 0,nc)
   if nc gt 3 then result=setunion(result,where(datadefect eq i))
   if nc eq 2 then begin
    n1=clustersta[neighborcluster[0]]
    n2=clustersta[neighborcluster[1]]
    if ((n1/(n1+n2)) gt 0.4) and ((n2/(n1+n2)) ge 0.4) then result=setunion(result,where(datadefect eq i))
   endif
   if nc eq 3 then begin
    n1=clustersta[neighborcluster[0]]
    n2=clustersta[neighborcluster[1]]
    n3=clustersta[neighborcluster[2]]
    if ((n1/(n1+n2+n3)) gt 0.2) and ((n2/(n1+n2+n3)) ge 0.2) and ((n3/(n1+n2+n3)) gt 0.2)then result=setunion(result,where(datadefect eq i))
   endif   
  endfor
 endif
 n_result=n_elements(result)
 result=result[1:n_result-1]
 ;if keyword_set(whereflag) then return,result
 whereflag=result
 result=bond[*,result]
 return,result
end

;=================================================================================================================================================================
;========================================================================================================================================================================
pro nuclei_grain_overall,bond,deltar1st=deltar1st,deltar2nd=deltar2nd,deltar3rd=deltar3rd,qq6m=qq6m,name=name,whereflag_thin=whereflag_thin
if (not keyword_set(deltar1st)) or (not keyword_set(deltar1st)) or (not keyword_set(deltar1st)) then begin
 print,'deltar1st || deltar2nd || deltar3rd not set...'
 gr=ericgr3d(bond,rmin=1,rmax=10,deltar=0.1)
 return
endif
if (not keyword_set(qq6m)) then begin
 print,'qq6m not set...'
 return
endif
if (not keyword_set(name)) then begin
 print,'name not set...'
 return
endif
ncol=n_elements(bond[*,0])
tmax=max(bond[ncol-1,*])
tmin=min(bond[ncol-1,*])
for i=tmin,tmax do begin
 wt=where(bond[ncol-1,*] eq i)
 bondt=bond[*,wt]
 qq6mt=qq6m[*,wt]
 second=search_second_neigh(bondt,deltar=deltar2nd,length=deltar3rd,qq6m=qq6mt,bondorder=bondorder)
 wcrystal=where(bondorder ge 0.8)
 idnuclei3,bondt[*,wcrystal],data,list=list,deltar=deltar1st,looptime=2,bondorder_threshold=7
 clusterorigin=fltarr(n_elements(bondt[0,*]))
 clusterorigin[wcrystal]=data
 print,max(clusterorigin)
 window,/free
 wcrystal=where(clusterorigin ne 0)
 plot,bondt[0,wcrystal],bondt[1,wcrystal],title='time'+string(i),psym=3
 class=crystal_growth_3d(clusterorigin,qq6mt,deltar=deltar1st,q6colation=q6colation,trb=bondt,/noplot)   ;;;;;;;  no plot?
 boundary_thin=search_grain_boundary(bondt,class,deltar=deltar1st,whereflag=whereflag_thin)
 boundary_thick=search_grain_boundary(bondt,class,deltar=deltar1st,/with_defects,whereflag=whereflag_thick)
 ;***************************************************
 ;tetra aggregation particle
 ;boundary_thin_temp=fltarr(n_elements(boundary_thin[*,0])+1,n_elements(boundary_thin[0,*]))
 ;boundary_thick_temp=fltarr(n_elements(boundary_thick[*,0])+1,n_elements(boundary_thick[0,*])) 
 ;boundary_thick_temp[0:n_elements(boundary_thick[*,0])-2,*]=boundary_thick[0:n_elements(boundary_thick[*,0])-2,*]
 ;boundary_thick_temp[n_elements(boundary_thick[*,0]),*]=boundary_thick[n_elements(boundary_thick[*,0])-1,*]
 ;boundary_thin_temp[0:n_elements(boundary_thin[*,0])-2,*]=boundary_thin[0:n_elements(boundary_thin[*,0])-2,*]
 ;boundary_thin_temp[n_elements(boundary_thin[*,0]),*]=boundary_thin[n_elements(boundary_thin[*,0])-1,*] 
 fcco=fccboo3dnew_revised1(bondt,abcc=abcc,bfcc=bfcc,chcp=chcp,dbccmicro=dbccmicro,efccmicro=efccmicro,fhcpmicro=fhcpmicro)
 bondt_thin=fltarr(n_elements(bondt[*,0])+1,n_elements(bondt[0,*]))
 bondt_thick=fltarr(n_elements(bondt[*,0])+1,n_elements(bondt[0,*]))
 bondt_thin[0:n_elements(bondt[*,0])-2,*]=bondt[0:n_elements(bondt[*,0])-2,*]
 bondt_thick[0:n_elements(bondt[*,0])-2,*]=bondt[0:n_elements(bondt[*,0])-2,*]
 bondt_thin[n_elements(bondt[*,0]),*]=bondt[n_elements(bondt[*,0])-1,*]
 bondt_thick[n_elements(bondt[*,0]),*]=bondt[n_elements(bondt[*,0])-1,*]
 tetra_qhull,bondt,tr2,tr3
 tetraid=where(tr3[4,*] ge 12 and bondt[3,*] le 7 and bondt[5,*] le 0.27)
 tetraid_thin=setintersection(tetraid,whereflag_thin)
 tetraid_thick=setintersection(tetraid,whereflag_thick)
 bondt_thin[n_elements(boundary_thin[*,0])-1,tetraid_thin]=4
 bondt_thick[n_elements(boundary_thick[*,0])-1,tetraid_thick]=4
 ;precursors particle
 precursorsid=where(bondt[3,*] le 7 and bondt[5,*] ge 0.27)
 precursorsbccid_thin=setintersection(dbccmicro,whereflag_thin)
 precursorsfccid_thin=setintersection(efccmicro,whereflag_thin)
 precursorshcpid_thin=setintersection(fhcpmicro,whereflag_thin)
 precursorsbccid_thick=setintersection(dbccmicro,whereflag_thick)
 precursorshcpid_thick=setintersection(efccmicro,whereflag_thick)
 precursorsfccid_thick=setintersection(fhcpmicro,whereflag_thick)
 ;precursorsid_thin=setintersection(precursorsid,whereflag_thin)
 ;precursorsid_thick=setintersection(precursorsid,whereflag_thick)
 bondt_thin[n_elements(boundary_thin[*,0])-1,precursorsbccid_thin]=21
 bondt_thin[n_elements(boundary_thin[*,0])-1,precursorshcpid_thin]=22
 bondt_thin[n_elements(boundary_thin[*,0])-1,precursorsfccid_thin]=23
 bondt_thin[n_elements(boundary_thick[*,0])-1,precursorsbccid_thick]=21
 bondt_thin[n_elements(boundary_thick[*,0])-1,precursorshcpid_thick]=22
 bondt_thin[n_elements(boundary_thick[*,0])-1,precursorsfccid_thick]=23
 ;pure liquid
 pureliquidid=where(tr3[4,*] lt 12 and bondt[3,*] le 7 and bondt[5,*] le 0.27)
 pureliquidid_thin=setintersection(pureliquidid,whereflag_thin)
 pureliquidid_thick=setintersection(pureliquidid,whereflag_thick)
 bondt_thin[n_elements(boundary_thin[*,0])-1,pureliquidid_thin]=3
 bondt_thick[n_elements(boundary_thick[*,0])-1,pureliquidid_thick]=3
 ;crystal 
 crystalstructureid=where(bondt[3,*] gt 7)
 ;crystalstructureid_thin=setintersection(crystalstructureid,whereflag_thin)
 ;crystalstructureid_thick=setintersection(crystalstructureid,whereflag_thick) 
 crystalstructurebccid_thin=setintersection(abcc,whereflag_thin)
 crystalstructurefccid_thin=setintersection(bfcc,whereflag_thin)
 crystalstructurehcpid_thin=setintersection(chcp,whereflag_thin)
 crystalstructurebccid_thick=setintersection(abcc,whereflag_thick)
 crystalstructurefccid_thick=setintersection(bfcc,whereflag_thick)
 crystalstructurehcpid_thick=setintersection(chcp,whereflag_thick)
 bondt_thin[n_elements(boundary_thin[*,0])-1,crystalstructurebccid_thin]=11
 bondt_thin[n_elements(boundary_thin[*,0])-1,crystalstructurehcpid_thin]=12
 bondt_thin[n_elements(boundary_thin[*,0])-1,crystalstructurefccid_thin]=13
 bondt_thin[n_elements(boundary_thick[*,0])-1,crystalstructurebccid_thick]=11
 bondt_thin[n_elements(boundary_thick[*,0])-1,crystalstructurehcpid_thick]=12
 bondt_thin[n_elements(boundary_thick[*,0])-1,crystalstructurefccid_thick]=13
 ;bondt_thin[n_elements(boundary_thin[*,0])-1,crystalstructureid_thin]=4
 ;bondt_thick[n_elements(boundary_thick[*,0])-1,crystalstructureid_thick]=4 
 ;***************************************************
 write_nuclei_and_boundary,bondt,class,boundary_thin=bondt_thin[*,whereflag_thin],boundary_thick=bondt_thick[*,whereflag_thick],name=name+'time'+string(i),/txt
 write_gdf,class,name+'time'+string(i)+' class.gdf'
endfor
end