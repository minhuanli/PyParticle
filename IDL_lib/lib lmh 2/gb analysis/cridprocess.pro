
for i=0,483 do begin
 fi = eclip(f,[8,i,i])
 bond=bondvoi(fi,dr=2.8,method=2,qq6m=qq6m)
    max1=max(bond(0,*))-3-2
    may1=max(bond(1,*))-3-2
    maz1=max(bond(2,*))-3-2
    mix1=min(bond(0,*))+3+2
    miy1=min(bond(1,*))+3+2
    miz1=min(bond(2,*))+3+2
  w=where(bond(0,*) gt mix1 and bond(0,*) lt max1 and bond(1,*) gt miy1 and bond(1,*) lt may1 and bond(2,*) gt miz1 and bond(2,*) lt maz1)
  bondc=bond(*,w)
  qq6mc=qq6m(*,w)
  crid=grain_class(bondc,deltar1st=2.8,deltar2nd=4.6,deltar3rd=6.4,qq6m=qq6mc)

;write_gdf,data,'E:\liminhuan\1\0909p1 f'+string(i)+'.gdf'
;write_gdf,data,'0513p4 b'+string(i)+'.gdf'
;write_gdf,tr33,'0513p4 tr33'+string(i)+'.gdf'
write_gdf,bond,'gbdynamic1026 bond'+string(i)+'.gdf'
write_gdf,crid,'gbdynamic1026 crid'+string(i)+'.gdf'

print,'gbdynamic1026'+string(i)

endfor
end