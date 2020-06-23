
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
  if nc le 40 then continue
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

;----------------------------------------------------------
function grain_class,bond,deltar1st=deltar1st,deltar2nd=deltar2nd,deltar3rd=deltar3rd,qq6m=qq6m

if (not keyword_set(deltar1st)) or (not keyword_set(deltar1st)) or (not keyword_set(deltar1st)) then begin
 print,'deltar1st || deltar2nd || deltar3rd not set...'
 gr=ericgr3d(bond,rmin=1,rmax=10,deltar=0.1)
 return,[-1]
endif
if (not keyword_set(qq6m)) then begin
 test=q4q6_origin(bond,deltar=deltar1st,qq6m=qq6m)
endif
 second=search_second_neigh(bond,deltar=deltar2nd,length=deltar3rd,qq6m=qq6m,bondorder=bondorder,cutoff=0.7)
 wcrystal=where(bondorder ge 0.85)
 idnuclei3,bond[*,wcrystal],data,list=list,deltar=deltar1st,looptime=3,bondorder_threshold=7
 clusterorigin=fltarr(n_elements(bond[0,*]))
 clusterorigin[wcrystal]=data
 print,max(clusterorigin)
 wcrystal=where(clusterorigin ne 0)
 plot,bond[0,wcrystal],bond[1,wcrystal],title='nuclei cluster',psym=3
 class=crystal_growth_3d(clusterorigin,qq6m,deltar=deltar1st,q6colation=q6colation,trb=bond,/noplot)
 
 return,class
 
 end