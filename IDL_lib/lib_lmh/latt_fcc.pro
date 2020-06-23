;-------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------
pro idcluster2,data,data2,list=list,deltar=deltar,conl=conl
 n1=n_elements(data(0,*))
 ;dm1=conlist(data,deltar=deltar,bondmax=20);
 if (keyword_set(conl)) then dm1=conl else dm1=conlist(data,deltar=deltar,bondmax=1000)
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
    for j=1L,dm1[visited[tail1],0] do begin
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
 data2=fltarr(indice,n1)
 list=fltarr(5,indice)
 for i=1.,indice do begin
  w=where(idd[*] eq i,nc)
  list[0,i-1]=nc
  data2[i-1,w]=1
  list[1,i-1]=mean(data(0,w))
  list[2,i-1]=mean(data(1,w))
  list[3,i-1]=mean(data(2,w))
 endfor
 data2=transpose(data2)
end

;===============================================================================================================
;---------------------------------------------------------------------------------------------------------
;select a certain cluster
;nb is the cluster index
function selecluster2,data,c01=c01,nb=nb
  n=n_elements(nb)
  da=c01(*,nb(0))
  w=where(da gt 0)
  temp=data(*,w)
  if n gt 1 then begin
    for i=1,n-1 do begin
      da=c01(*,nb(i))
      w=where(da gt 0)
      temp1=data(*,w)
      temp=[[temp],[temp1]]
  endfor
endif

return,temp

end

;=================================================================================================================
; this function can output a lattice position with average over the whole neighbour particels in a grain
; prj is the projection results on the standard sphere,(0:2) contains x,y,z; 3 contains the origin distance to the center particle
; dc is the cutoff distance to judge whether the two particels are in one cluster
; the output: 0)mean x  1)mean y   2)mean z  3)distance   4)deviation  5) cluster number 
function latt_rhcp, prj=prj, dc=dc, hcp=hcp,fcc=fcc,ampli=ampli,nb=nb
  ttt=18
  if (not keyword_set(ampli)) then ampli=1. 
  if keyword_set(hcp) then ttt=18
  if keyword_set(fcc) then ttt=12 
  if keyword_set(nb) then ttt=nb
  idcluster2,prj(0:2,*), c01 ,list=s01, deltar=dc
  nn=n_elements(s01(0,*))
  print,nn
  nn=min([nn,ttt])
  w=reverse(sort(s01(0,*)))
  s01=s01(*,w(0:nn-1))
  c01=c01(*,w(0:nn-1))  
  result=fltarr(6,nn)
  for i=0,nn-1 do begin
     clui=selecluster2(prj,c01=c01,nb=i)
     dist=mean(clui(3,*))
     dev=stddev(clui(3,*)) 
     apos=s01(1:3,i)
     ratio= dist / 5.
     poss= apos * ratio
     result(0:2,i)=poss
     result(3,i)=dist
     result(4,i)=dev
     result(5,i)=n_elements(clui(0,*))
  endfor
  result(0:2,*)=result(0:2,*)*ampli
  return, result

end
     
