;calculate bonds in a single frame
;for bonds near edges, bond lengths and angles are wrong
;parameter B in triangulate.pro or tlist in ubons.pro
;can not remove the bad bonds near edge. Hanbonds.pro
;will keep those bonds which shoule be removed in final analysis
function Hanbond1,xy,xmin,xmax,ymin,ymax

triangulate,xy[0,*],xy[1,*],triangles, connectivity = list
ubonds,triangles,bonds
;;;;choose only good bonds, cut the edge: any one of the two point at edge will be cut
p=where(xy[0,bonds[0,*]] gt xmin and xy[0,bonds[0,*]] lt xmax $
  and xy[0,bonds[1,*]] gt xmin and xy[0,bonds[1,*]] lt xmax $
  and xy[1,bonds[0,*]] gt ymin and xy[1,bonds[0,*]] lt ymax $
  and xy[1,bonds[1,*]] gt ymin and xy[1,bonds[1,*]] lt ymax)
bonds=bonds[*,p]
Hanbondlengthangle,xy,bonds,lengthangle
;return,[[bonds],float([lengthangle])] ;bond is label of points, not very useful but occupu memory
return,[float([lengthangle])]
end


;calculate bonds of many frames
;xmin etc.: ~ 10pixel smaller than xyt data range
;only bonds in the central region is considered in Hanbond1
;bonds near edges are not accurate, e.g. length too long.
;;old output:[#of ptcl1,# of ptcl2, x &y of bond center, bond length, bondangel [-pi,pi],frame#
;new output:[x &y of bond center, bond length, bondangel [-pi,pi],frame#

pro Hanbondall,xyt,xmin,xmax,ymin,ymax,outfile

framepoints,xyt[2,*],nframe,fp
;res=fltarr(7) ;make a initial array for [[res],[add]]
res=fltarr(5)
for i=0,nframe-1 do begin
  xy=xyt[0:1,fp[i]:fp[i+1]-1]
  tmp=Hanbond1(xy,xmin,xmax,ymin,ymax)
  xy=0
  n=n_elements(tmp[0,*])
  tmp=[[tmp],transpose([fltarr(n)])]
  tmp[4,*]=i ;frame #, i.e. time
  res=[[res],[tmp]]
endfor
n=n_elements(res[0,*])
write_gdf,res[*,1:n-1],outfile
end
