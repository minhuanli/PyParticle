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
 list=fltarr(6,indice)
 for i=1.,indice do begin
  w=where(idd[*] eq i,nc)
  list[0,i-1]=nc
  data2[i-1,w]=1
  list[1,i-1]=mean(data(0,w))
  list[2,i-1]=mean(data(1,w))
  list[3,i-1]=mean(data(2,w))
  list[4,i-1]=sqrt(mean( (data(0,w)-mean(data(0,w)))^2 + (data(1,w)-mean(data(1,w)))^2 + (data(2,w)-mean(data(2,w)))^2 ))
  ;list[5,i-1]=mean(data(8,w)) 
 endfor
 data2=transpose(data2)
end
