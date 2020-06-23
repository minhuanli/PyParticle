;--------------------------------------------------------------------------------
;----------------------------------------------------------------------------------
function findid,cpdata=cpdata,data=data,fail=fail
  ww=n_elements(cpdata(0,*))
  id=lonarr(ww)
  fail=[-1]
  for i=0L,ww-1 do begin
    w=where(data(0,*) eq cpdata(0,i) and data(1,*) eq cpdata(1,i) and data(2,*) eq cpdata(2,i), nw)
    if nw ge 1 then begin
      id(i)=w(0)
    endif else begin
      print,'find no corresponding particle in the background particles'
      fail=[fail,i]
    endelse
  endfor
  
  return,id
  
  end
;----------------------------------------------------------------------------------


function search_nearest,trb,bondnum=bondnum,cpid=cpid,dc=dc
start=systime(/second)
particlenum=n_elements(cpid)
pos=trb[0:2,*]
con=fltarr(particlenum,31)
for s=0.,particlenum-1 do begin
 j=cpid[s]
 dx=pos(0,*)-pos(0,j)
 dy=pos(1,*)-pos(1,j)
 dz=pos(2,*)-pos(2,j)
 wwww=where(abs(dx) le dc and abs(dy) le dc and abs(dz) le dc,nwwww)
 dx=dx[0,wwww]
 dy=dy[0,wwww]
 dz=dz[0,wwww]
 a1=(dx)^2+(dy)^2+(dz)^2
 aa1=sort(a1)
 if nwwww le 1 then continue
 ww=aa1[1:bondnum]
 aaa1=a1[ww]
 con[s,0]=bondnum
 con[s,1:con[s,0]]=wwww[ww]
endfor
result=con
endtime=systime(/second)
print,'running time',endtime-start
return,result
end


function matching_neighbor,trb1,trb2,error=error
n=n_elements(trb1[0,*])
result=fltarr(n)
error=0
for i=0,n-1 do begin
 dis=(trb2[0,*]-trb1[0,i])^2+(trb2[1,*]-trb1[1,i])^2+(trb2[2,*]-trb1[2,i])^2
 mindis=min(dis,minidd)
 result[i]=minidd
endfor
error=total(sqrt(total((trb2[0:2,result]-trb1[0:2,*])^2,1)))
return,result
end


function D3_rotate,x,y,z,theta,vec
matrix=fltarr(3,3)
matrix[0,0]=cos(theta)+(1-cos(theta))*x^2
matrix[0,1]=(1-cos(theta))*x*y-sin(theta)*z
matrix[0,2]=(1-cos(theta))*x*z+sin(theta)*y
matrix[1,0]=(1-cos(theta))*y*x+(sin(theta))*z
matrix[1,1]=cos(theta)+(1-cos(theta))*y^2
matrix[1,2]=(1-cos(theta))*y*z-(sin(theta))*x
matrix[2,0]=(1-cos(theta))*z*x-sin(theta)*y
matrix[2,1]=(1-cos(theta))*z*y+(sin(theta)*x)
matrix[2,2]=cos(theta)+(1-cos(theta))*z^2
result=matrix#vec
return,result
end


function rotate_vector_bcc,vec,angle,r
vec0=r*vec[0:2]/norm(vec[0:2])
vec0[2]=0
vec1=[vec0[0]*cos(angle)+vec0[1]*sin(angle),-vec0[0]*sin(angle)+vec0[1]*cos(angle),0]
vec2=[vec0[0]*cos(!pi)+vec0[1]*sin(!pi),-vec0[0]*sin(!pi)+vec0[1]*cos(!pi),0]
vec3=[vec0[0]*cos(!pi+angle)+vec0[1]*sin(!pi+angle),-vec0[0]*sin(!pi+angle)+vec0[1]*cos(!pi+angle),0]
return,[[vec0],[vec1],[vec2],[vec3]]
end

function rotate_vector_rhcp,vec,angle,r
vec0=r*vec[0:2]/norm(vec[0:2])
vec0[2]=0
vec1=[vec0[0]*cos(angle)+vec0[1]*sin(angle),-vec0[0]*sin(angle)+vec0[1]*cos(angle),0]
vec2=[vec0[0]*cos(2*angle)+vec0[1]*sin(2*angle),-vec0[0]*sin(2*angle)+vec0[1]*cos(2*angle),0]
vec3=[vec0[0]*cos(3*angle)+vec0[1]*sin(3*angle),-vec0[0]*sin(3*angle)+vec0[1]*cos(3*angle),0]
vec4=[vec0[0]*cos(4*angle)+vec0[1]*sin(4*angle),-vec0[0]*sin(4*angle)+vec0[1]*cos(4*angle),0]
vec5=[vec0[0]*cos(5*angle)+vec0[1]*sin(5*angle),-vec0[0]*sin(5*angle)+vec0[1]*cos(5*angle),0]
return,[[vec0],[vec1],[vec2],[vec3],[vec4],[vec5]]
end


function create_standard_bcc,r,method=method
 vecnew=rotate_vector_bcc([5,0,0],1.230959417,r)
 vecc01up=0.5*(vecnew[*,0]+vecnew[*,1])
 vecc12up=0.5*(vecnew[*,1]+vecnew[*,2])
 vecc23up=0.5*(vecnew[*,2]+vecnew[*,3])
 vecc30up=0.5*(vecnew[*,3]+vecnew[*,0])
 vecc01up=[vecc01up[0:1],sqrt(6)*r/3.]
 vecc12up=[vecc12up[0:1],sqrt(6)*r/3.]
 vecc23up=[vecc23up[0:1],sqrt(6)*r/3.]
 vecc30up=[vecc30up[0:1],sqrt(6)*r/3.]
 vecc01down=-vecc01up
 vecc12down=-vecc12up
 vecc23down=-vecc23up
 vecc30down=-vecc30up
 vecc2nd01=(vecnew[*,0]+vecnew[*,1])
 vecc2nd12=(vecnew[*,1]+vecnew[*,2])
 vecc2nd23=(vecnew[*,2]+vecnew[*,3])
 vecc2nd30=(vecnew[*,3]+vecnew[*,0]) 
 if method eq 1 then vecideal=[[vecnew],[vecc12up],[vecc30up],[vecc12down],[vecc30down]]
 if method eq 2 then vecideal=[[vecnew],[vecc01up],[vecc12up],[vecc23up],[vecc30up],[vecc01down],[vecc12down],[vecc30down],[vecc23down],[vecc2nd12],[vecc2nd30]]
 return,vecideal
end


function create_standard_rhcp,r
 vecnew=rotate_vector_rhcp([5,0,0],!pi/3,r)
 vecc01up=(vecnew[*,0]+vecnew[*,1])/3.
 vecc12up=(vecnew[*,1]+vecnew[*,2])/3.
 vecc23up=(vecnew[*,2]+vecnew[*,3])/3.
 vecc34up=(vecnew[*,3]+vecnew[*,4])/3.
 vecc45up=(vecnew[*,4]+vecnew[*,5])/3.
 vecc50up=(vecnew[*,5]+vecnew[*,0])/3.
 vecc01up=[vecc01up[0:1],sqrt(6)*r/3.]
 vecc12up=[vecc12up[0:1],sqrt(6)*r/3.]
 vecc23up=[vecc23up[0:1],sqrt(6)*r/3.]
 vecc34up=[vecc34up[0:1],sqrt(6)*r/3.]
 vecc45up=[vecc45up[0:1],sqrt(6)*r/3.]
 vecc50up=[vecc50up[0:1],sqrt(6)*r/3.]
 vecc01down=-vecc01up
 vecc12down=-vecc12up
 vecc23down=-vecc23up
 vecc34down=-vecc34up
 vecc45down=-vecc45up
 vecc50down=-vecc50up
 vecideal=[[vecnew],[vecc01up],[vecc12up],[vecc23up],[vecc34up],[vecc45up],[vecc50up],[vecc01down],[vecc12down],[vecc23down],[vecc34down],[vecc45down],[vecc50down]]
 vecideal=[[vecnew],[vecc01up],[vecc23up],[vecc45up],[vecc12down],[vecc34down],[vecc50down]]
 return,vecideal
end


function adjust_neigh,prj,refer=refer,subrefer=subrefer
nei=n_elements(prj[0,*])
error1=99999
for i=0.,nei-1 do begin ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 for j=0,nei-1 do begin
  vec=crossp(refer[0:2,i],prj[0:2,j])
  vec=vec/norm(vec)
  theta=cal_angle(refer[0:2,i],prj[0:2,j])
  prj_temp=D3_rotate(vec[0],vec[1],vec[2],theta,prj[0:2,*])
  if norm(prj_temp[0:2,j]-refer[0:2,i]) gt 0.001 then begin
   theta=-theta
   prj_temp=D3_rotate(vec[0],vec[1],vec[2],theta,prj[0:2,*])
  endif
  matchingneiid=matching_neighbor(prj_temp,refer[0:2,*],error=error)
  matchingnei=prj_temp
  matchingnei=matchingnei
  
  if error1 ge error then begin
   result=[[matchingnei,prj[3,*]]]
   error1=error
   temp_refer=refer[0:2,*]
   for k=0.,nei-1 do begin
    www=where(matchingneiid eq k,nc)
    if nc eq 0 then continue
    if nc eq 1 then temp_refer[*,k]=prj_temp[*,www]
    if nc gt 1 then begin
     dis=total((prj_temp[*,www]-refer[0:2,[k,k]])^2,1)
     dismin=min(dis,disid)
     temp_refer[*,k]=prj_temp[*,www[disid]]
    endif
   endfor
  endif
 
 endfor
endfor
subrefer=subrefer+temp_refer
return,result
end




;---------------------------------------------------------------------------------
function prj_precursor_1, cpdata=cpdata,data=data,nmax=nmax,rm=rm,idd=idd,bcc=bcc,rhcp=rhcp
  start1=systime(/second)
  if keyword_set(idd) then cpid=cpdata else cpid=findid(cpdata=cpdata,data=data)
  list=search_nearest(data,bondnum=nmax,cpid=cpid,dc=rm)
  nn=n_elements(cpid) 
  flag=0
  result=[-1.,-1.,-1.,-1.]
  ;if keyword_set(bcc) then refer=create_standard_bcc(5)
  ;if keyword_set(rhcp) then refer=create_standard_rhcp(5)
  ;subrefer=refer
  for ks=0,50 do begin
  for j=0l,nn-1 do begin
    nnn=nmax; the number of neighborhood
    nb1=list(j,1:nnn) ; nb1: id of neighborhood
    if nnn le 0 then continue
    pos0=data(0:2,cpid(j))
    prjj=fltarr(4,nnn)
      for k=0,nnn-1 do begin
        posk=data(0:2,nb1(k))- pos0
        ratio=5./norm(posk)
        prjk=posk*ratio
        prjj(*,k)=[prjk,norm(posk)]
      endfor
    
    if flag eq 0 then begin
     refer=prjj
     subrefer=refer
     flag=1
    endif else begin  
    
     prjj=adjust_neigh(prjj,refer=refer,subrefer=subrefer)
    endelse 
    if ks lt 50 then continue
    result=[[result],[prjj]]
  endfor
  print,ks  
  print,subrefer/float(nn)
  subrefer=subrefer/float(nn)
  refer=subrefer
  endfor
  n=n_elements(result(0,*))
  endtime1=systime(/second)
  print,'prj running time',endtime1-start1
  return,result(*,1:n-1)  
end
    
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  



