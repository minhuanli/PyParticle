;trd is the tracked data after dedrifting, for 2d data;  nndr is the average nearest number distance
;output, 0: particle id   1: lidemann parameter  2: time count number 
; lmh 2018/8/30 @tokyo U tanaka lab
function lindman_lmh,trd,idlist=idlist,nndr=nndr
dimn = n_elements(trd(*,0))
npar = trd(dimn-1,*)
npar = npar(uniq(npar))
if keyword_set(idlist) then idlist = idlist else idlist = npar
n1 = n_elements(idlist)
res= fltarr(3,n1)
for j = 0,n1-1 do begin
 w = where(trd(dimn-1,*) eq idlist(j),nw)
 posj = trd(0:1,w)  ; position of single pariticle across time
 posj(0,*) = posj(0,*) - mean(posj(0,*))
 posj(1,*) = posj(1,*) - mean(posj(1,*))
 disj = sqrt(mean(posj(0,*)^2 + posj(1,*)^2))
 res(0,j) = idlist(j)
 res(1,j) = disj / nndr
 res(2,j) = nw
endfor

return,res

end
 
; 3d version
function lindman3d_lmh,trd,idlist=idlist,nndr=nndr
dimn = n_elements(trd(*,0))
npar = trd(dimn-1,*)
npar = npar(uniq(npar))
if keyword_set(idlist) then idlist = idlist else idlist = npar
n1 = n_elements(idlist)
res= fltarr(12,n1)
for j = 0L,n1-1 do begin
 w = where(trd(dimn-1,*) eq idlist(j),nw)
 posj = trd(0:2,w)  ; position of single pariticle across time
 posj(0,*) = posj(0,*) - mean(posj(0,*))
 posj(1,*) = posj(1,*) - mean(posj(1,*))
 posj(2,*) = posj(2,*) - mean(posj(2,*))
 disj = sqrt(mean(posj(0,*)^2 + posj(1,*)^2 + posj(2,*)^2))
 res(0,j) = idlist(j)
 res(1,j) = disj / nndr
 res(2,j) = nw
 res(3,j) = sqrt(mean(posj(0,*)^2)) / nndr
 res(4,j) = sqrt(mean(posj(1,*)^2)) / nndr
 res(5,j) = sqrt(mean(posj(2,*)^2)) / nndr
 res(6,j) = mean(trd(5,w))
 res(7,j) = mean(trd(8,w))
 res(8,j) = mean(trd(7,w))
 res(9,j) = mean(trd(0,w))
 res(10,j) = mean(trd(1,w))
 res(11,j) = mean(trd(2,w))
endfor

return,res

end

 
 
 
 