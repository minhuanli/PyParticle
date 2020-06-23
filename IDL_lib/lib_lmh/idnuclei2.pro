; this program identifies the crystal nuclei!
pro idnuclei2,data,data2,list=list,deltar=deltar,conl=conl,type=type
 n1=n_elements(data(0,*))
 ;dm1=conlist(data,deltar=deltar,bondmax=20);
 if (keyword_set(conl)) then dm1=conl else dm1=conlist(data,deltar=deltar,bondmax=40)
 
case type of
    1: begin
       nl=1
       nc=6
       end
    2: begin
       nl=3 
       nc=7
       end
    3: begin
       nl=6
       nc=8
       end
    4: begin
       nl=4
       nc=7
       end
    ELSE:
  ENDCASE
  
   
 for i=0,nl do begin
 w=where(dm1[*,0] le nc,nw)
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
 data2=fltarr(1,n1)
 list=fltarr(4,1)
 for i=1.,indice do begin
  w=where(idd[*] eq i,nc)
  if nc le 20 then continue
  temp=fltarr(1,n1)
  temp[w]=1
  data2=[data2,temp]
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
  if nlist le 1 then begin
  print, 'no enough particles!'
  list=[0,0,0,0]
  endif else begin
  list=list(*,1:(nlist-1))
  data2=data2(*,1:(nlist-1))
  line1=reverse(sort(list(0,*)))
  list=list(*,line1)
  data2=data2(*,line1)
  endelse
end
