;loop twice
function compensate3d,bond,orcluster,deltar=deltar,extra=extra
 particlenum=n_elements(orcluster[0,*])
 pos=bond[0:2,*]
 result=[-1]
 original=[-1]
 for i=0,particlenum-1 do begin
  pos=selectnearest(bond,cp=orcluster[0:2,i],rmax=deltar,nmax=15,id=id)
  pos=selectnearest(bond,cp=orcluster[0:2,i],rmax=0.5,nmax=1,id=idd)
  result=setunion(result,id)
  original=setunion(original,idd)
 endfor
 wr=where(result ge 0)
 result=result[wr]
 extra=setdifference(result,original)
 return,result
end