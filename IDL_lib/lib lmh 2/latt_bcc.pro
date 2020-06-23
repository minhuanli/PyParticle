;group the bcc's neighbours to two teams: 8 and 6
;group by the angle, the 6 group have 4 angle lie around pi/2
;output 0)6/8 1)x 2)y 3)z
function grobcc11, pos=pos
n=n_elements(pos(0,*))
indice=fltarr(1,n)
poss=[indice,pos]
s=0
e=0
for i=0,n-1 do begin
   v=poss(1:3,i)
   temp=fltarr(1,n)
   for j=0,n-1 do begin
      temp(j)=cal_angle(v,poss(1:3,j))
   endfor
   w=where(temp gt 1.45 and temp lt 1.69,nc)
   if (nc eq 4) then begin
     poss(0,i)=6
     s=s+1 
   endif else begin
     poss(0,i)=8
     e=e+1
   endelse
endfor  

;w=sort(poss(0,*))
;poss=poss(*,w)

print,s
print,e
return,poss
end

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
; this function can output a lattice position with average over the whole neighbour particels of bcc
; prj is the projection results on the standard sphere,(0:2) contains x,y,z; 3 contains the origin distance to the center particle
; dc is the cutoff distance to judge whether the two particels are in one cluster
; the output: 1)mean x  2)mean y   3)mean z  4)distance   5)deviation   0)6/8( mean the neighbor type); 6)cluster number 
; the sequence is from large to small cluster
function latt_bcc, prj=prj, dc=dc, ampli=ampli
  if (not keyword_set(ampli)) then ampli=1.
  idcluster2, prj(0:2,*), c01 ,list=s01, deltar=dc
  nn=n_elements(s01(0,*))
  print,nn
  nn=min([nn,14])
  w=reverse(sort(s01(0,*)))
  s01=s01(*,w(0:nn-1))
  c01=c01(*,w(0:nn-1))  
  
  result=fltarr(7,nn)
  for i=0,nn-1 do begin
     clui=selecluster2(prj,c01=c01,nb=i)
     dist=mean(clui(3,*))
     dev=stddev(clui(3,*)) 
     apos=s01(1:3,i)
     ratio= dist / 5.
     poss= apos * ratio
     result(1:3,i)=poss
     result(4,i)=dist
     result(5,i)=dev
     result(6,i)=n_elements(clui(0,*))
  endfor
  gro=grobcc11( pos=result(1:3,*) )
  result(0,*)=gro(0,*)
  result(1:3,*)=result(1:3,*)*ampli
  w=sort(result(0,*))
  result=result(*,w)
  return,result
end
     
   