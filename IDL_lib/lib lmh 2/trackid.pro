; ncol-1 type ; ncol-2 tackid ; ncol-3 time 
function trackid,trbc=trbc,tr33c=tr33c,type=type
  ncol=n_elements(trbc(*,0))
  if type eq 1 then begin 
    w=where(trbc(3,*) ge 7)
    sld=trbc(*,w)
    idd=sld(ncol-2,*)
    idd=idd(sort(idd))
    idd=idd(uniq(idd))
    return,idd
  endif
  if type eq 2 then begin 
    w=where(trbc(3,*) le 6 and trbc(3,*) ge 3)
    pre=trbc(*,w)
    idd=pre(ncol-2,*)
    idd=idd(sort(idd))
    idd=idd(uniq(idd))
    return,idd
  endif
  if type eq 3 then begin 
    w=where(trbc(3,*) lt 3 and tr33c(3,*) ge 12)
    teag=trbc(*,w)
    idd=teag(ncol-2,*)
    idd=idd(sort(idd))
    idd=idd(uniq(idd))
    return,idd
  endif
  if type eq 4 then begin 
    w=where(trbc(3,*) lt 3 and tr33c(3,*) lt 12)
    liq=trbc(*,w)
    idd=liq(ncol-2,*)
    idd=idd(sort(idd))
    idd=idd(uniq(idd))
    return,idd
  endif
end