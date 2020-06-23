;screen the unphysical result of feature process: several particels are abnormally close, even overlap.
;dr is a distance cutoff,usually the partcile radius
;this function makes a position average of the crowed particles as a new one
;2016.10.13 version #1  by lmh

function conlist1,a2,deltar=deltar,bondmax=bondmax
 qhull,a2(0:2,*),tr,connectivity=c1,/delaunay
 n1=n_elements(a2(0,*))
 list=make_array(n1,bondmax+1,/nozero,/long,value=-1)
 for j=0.,n1-1 do begin
  b1=c1[c1[j]:c1[j+1]-1]
  bx1=(a2(0,j)-a2(0,b1))^2+(a2(1,j)-a2(1,b1))^2+(a2(2,j)-a2(2,b1))^2
  w=where(bx1 lt deltar^2,nc)
  if nc gt 0 then begin
   list[j,0]=nc
   list[j,1:nc]=b1[w]
  endif
 endfor
 return,list
end 

;----------------------------------------------------------------------------
;--------------------------------------------------------------------------
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
 data2=fltarr(indice,n1)
 list=fltarr(5,indice)
 for i=1.,indice do begin
  w=where(idd[*] eq i,nc)
  list[0,i-1]=nc
  data2[i-1,w]=1
  list[1,i-1]=mean(data(0,w))
  list[2,i-1]=mean(data(1,w))
  list[3,i-1]=mean(data(2,w))
  list[4,i-1]=mean(data(8,w))
 endfor
 data2=transpose(data2)
end
;-------------------------------------------------------------------


function scrcrowd,data,dr,id=id,cllist=cllist
list=conlist1(data,deltar=dr,bondmax=20)
w1=where(list(*,0) gt 0,nw1) ; with neighbour less than dr
w2=where(list(*,0) le 0,nw2) ; the other normal particles
;temp1=data(0:2,w2)
temp1=[data(0:2,w2),data(8,w2)]
 if nw1 gt 0 then begin
   print,'with crowded particles'
   id=w1 
   temp=data(*,w1)
;---------------cluster analysis--------------------
;------------inherit the neighboring list------------
   for i=0l,nw1-1 do begin
      idd=w1(i)
      w3=where(list(*) eq idd,nw3)
      list(w3)=i
      w4=where(list(w1(i),*) ge 0,nw4)
      list(w1(i),0)=nw4-1
    endfor
    newlist=list(w1,*)    
    idcluster2,temp,c01,list=cllist,deltar=dr,conl=newlist
    result=[[temp1],[cllist(1:4,*)]]
    return,result
  endif else begin
  print,'no crowed particles'
  return,data
  endelse 
end

  