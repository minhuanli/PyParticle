function grow_clustershell,clusterorigin,conl=conl,clusterid=clusterid
 w=where(clusterorigin eq clusterid,npar)
 ww=w
 for i=0L,npar-1 do begin
  neigh=conl[w[i],1:conl[w[i],0]]
  ww=setunion(ww,transpose(neigh))
 endfor
 return,setdifference(ww,w)
end



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