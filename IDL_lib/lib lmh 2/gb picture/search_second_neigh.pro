

function search_second_neigh,bond,deltar=deltar,length=length,qq6m=qq6m,bondorder=bondorder,cutoff=cutoff
particlenum=n_elements(bond[0,*])
result=fltarr(501,particlenum)
bondorder=fltarr(particlenum)
for i=0L,particlenum-1 do begin
 dx=bond[0,*]-bond[0,i]
 dy=bond[1,*]-bond[1,i]
 dz=bond[2,*]-bond[2,i]
 dr=dx^2+dy^2+dz^2
 w=where(dr le length^2 and dr gt deltar^2,nw)
 result[0,i]=nw
 result[1:nw,i]=w
 bondorder[i]=cal_bondorder(qq6m,result[*,i],i,dc=cutoff)/float(nw)
endfor
return,result
end