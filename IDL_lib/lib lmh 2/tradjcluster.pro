

FUNCTION SetIntersection, a, b
minab = min(a, MAX=maxa) > min(b, MAX=maxb) ;Only need intersection of

maxab = maxa < maxb
 
  ;If either set is empty, or their ranges don't intersect: result =

if maxab lt minab or maxab lt 0 then return, -1
r = where((histogram(a, MIN=minab, MAX=maxab) ne 0) and (histogram(b, MIN=minab, MAX=maxab) ne 0), count)
if count eq 0 then return, -1 else return, r + minab
end




;====================================================================
function tradjlist,a2,adj=adj,face=face
 qhull,a2(4:6,*),tr,connectivity=c1,/delaunay
 n1=n_elements(a2(0,*))
 list=lonarr(n1,100+1)
 for j=0.,n1-1 do begin
  b1=c1[c1[j]:c1[j+1]-1]
  nb1=n_elements(b1)
  if nb1 lt 1 then continue
  nc=0
  for k=0,nb1-1 do begin
    ww=setintersection(a2(0:3,j),a2(0:3,b1(k)))
    nww=n_elements(ww)
    if keyword_set(adj) then begin
      if nww ge 1 then begin
        nc=nc+1
        list[j,nc]=b1(k)           ;   only one vertice adjacent
      endif
    endif
    if keyword_set(face) then begin
      if nww eq 3 then begin
        nc=nc+1
        list[j,nc]=b1(k)           ;   face to face adjacent
      endif
    endif
   endfor
    
  if nc gt 0 then begin
   list[j,0]=nc
  endif
 endfor
 return,list
end





;==================================================================
; data is tr22, which 0:3 are vertice's index, 4:6 are mean x,y,z
; data2 and list are set to output
; adj and face are set to detect one-vertice connect or face-face connect 
pro tradjcluster,data,data2,list=list,conl=conl,adj=adj,face=face
 n1=n_elements(data(0,*))
 ;dm1=conlist(data,deltar=deltar,bondmax=20);
 
 if (keyword_set(conl)) then begin
     dm1=conl 
 endif else begin 
   ;print,'jj'
   if (keyword_set(adj)) then dm1=tradjlist(data,adj=adj)
   if (keyword_set(face)) then dm1=tradjlist(data,face=face)
 endelse
 
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
 
 iii=0
 for i=1.,indice do begin
  w=where(idd[*] eq i,nc)
  if nc lt 2 then continue  ; drop the single tetrahedron
  iii=iii+1
  data2t=fltarr(n1,1)
  listt=fltarr(4,1)
  listt(0)=nc
  data2t(w,0)=1
  listt(1)=mean(data(4,w))
  listt(2)=mean(data(5,w))
  listt(3)=mean(data(6,w))
  if iii eq 1 then begin 
     data2=data2t
     list=listt
  endif else begin
     data2=[[data2],[data2t]]
     list=[[list],[listt]]
  endelse
 endfor
 ;data2=transpose(data2)
end
