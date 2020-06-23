function trcut,tr
tra=tr
idaa=tra(3,*)
idbb=idaa(uniq(idaa,sort(idaa)))
nid=n_elements(idbb)
;satr2=[0,0,0,0]
wbb=0
ta=tra(2,*)
tb=ta(uniq(ta,sort(ta)))
ntb=n_elements(tb)
for j=0.,nid-1 do begin
;print,j
ws=where(tra(3,*) eq idbb[j],ns)
if ns gt 0.9*ntb then begin 
timeid=fltarr(1,ntb)-1
ts=tra(2,ws)
timeid(0,ts)=ts 
wb=where(timeid(0,*) eq -1,nwb)
if nwb gt 0 then begin
wbb=[wbb,wb] 
endif
endif
if ns le 0.9*ntb then begin
tra(3,ws)=-1
endif
endfor
wg=where(tra(3,*) ne -1)
tra=tra(*,wg)
nbc=n_elements(wbb)
if nbc gt 1 then begin
wbb=wbb(1:nbc-1)
timecut=wbb(uniq(wbb,sort(wbb)))
ncut=n_elements(timecut)
print,ncut
for j=0.,ncut-1 do begin
;print,j
wcut=where(tra(2,*) eq timecut[j])
tra(2,wcut)=-1
endfor
endif
wr=where(tra(2,*) gt -1)
tra=tra(*,wr)
naa=n_elements(tra(2,*))
idbb=tra(3,*)
idbb=idbb(uniq(idbb,sort(idbb)))
nidbb=n_elements(idbb)
nddt=naa/nidbb
print,nddt
print,nidbb
t1=findgen(1,nddt)
for j=0,nidbb-2 do begin
;print,j
t2=findgen(1,nddt)
t1=[[t1],[t2]]
endfor
tra(2,*)=t1
return,tra
end