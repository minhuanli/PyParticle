
function conlist1,a2,deltar=deltar,bondmax=bondmax
 qhull,a2(0:2,*),tr,connectivity=c1,/delaunay
 n1=n_elements(a2(0,*))
 list=make_array(n1,bondmax+1,/long,/nozero,value=-1)
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
;-----------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------
;====================================================================================================
function haindex,data,deltar=deltar,bondmax=bondmax,crnb=crnb
if (keyword_set(crnb)) then crnb=crnb else crnb=4
;---------------creat neighbor list---------------------
nblist=conlist1(data,deltar=deltar,bondmax=bondmax)
n1=n_elements(nblist(*,0))
index=[-1,-1,-1,-1]
pfile=make_array(7,1,/nozero,value=-1)
tindex=make_array(4,1,/nozero,value=-1)   
  for i=0,n1-1 do begin
    na=nblist(i,0)
    if na lt 0 then continue
    tempa=nblist(i,1:na)
      for j=i+1,n1-1 do begin
        nb=nblist(j,0)
        if nb lt 0 then continue
        tempb=nblist(j,1:nb)
  ;-----------------the first integer-------------      
        w=where(tempa eq j,nw1)
        if (nw1 gt 0) then tindex(0)=1 else tindex(0)=2
  ;----------------search the common neighbors between particle i and j,the second integer-------------         
        count=0
        comnb=[-1]
           for k=0,na-1 do begin
             tpfile=make_array(7,1,/nozero,value=0)
             aa=tempa(k)
             w=where(tempb eq aa,nw2)
             if (nw2 gt 0) then begin
             count=count+1
             comnb=[comnb,aa]
             endif
           endfor
        if (count lt crnb) then continue
        if (count gt 7) then continue       
        tindex(1)=count 
        comnb=comnb(1:count)
;--------------------the bond number between the common neighbors,the third integer------------------
           count3=0
           for k=0,(count-1) do begin         
              aaa=comnb(k)
                for l=0,(count-1) do begin
                   if (l eq k) then continue
                   bbb=comnb(l)
                   nbbb=nblist(bbb,0)
                   tempbbb=nblist(bbb,1:nbbb)
                   w=where(tempbbb eq aaa,nw3)
                   if (nw3 gt 0) then tpfile(k)=tpfile(k)+1
                   if (l lt k) then continue
                   if (nw3 gt 0) then count3=count3+1
                endfor 
           endfor
        tindex(2)=count3
        tindex(3)=1
;===============================judge 1421 and 1422===========================
        if (tindex(1) eq 4) and (tindex(2) eq 2) then begin    
            w=where(tpfile eq 2,nw4)
            if nw4 gt 0 then tindex(3)=2
        endif
;==========================================================================               
        index=[[index],[tindex]]
        pfile=[[pfile],[tpfile]]
      endfor
   endfor
  index=[index,pfile]
  n=n_elements(index(0,*))
  if n gt 1 then index=index(*,1:(n-1))
  indice=1000*index(0,*)+100*index(1,*)+10*index(2,*)+index(3,*)
  index=[indice,index]
  return,index
end
       





     
        
        
      
      