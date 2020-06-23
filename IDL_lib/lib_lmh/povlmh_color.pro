; pov-ray procedure
; whats special: give every particle a color value according to its own parameter
; Just a simple realization, i manually defined a 20-level color bar here;  from royal blue to orange
; input:  data, 0:2, x,y,z, particle position, 3 , the paramter value for color set ;  r, sphere radius;  clmin, min value on color bar; clmax, max value on color bar;
; if cl is not set , the default value will be set to the max and min value of the data.
; sid is the id of liquid particles
; boxid  
; log, if set, the input value will be logged before rank; 
Pro povlmh_color,odata, r = r, minc=minc, maxc=maxc ,boxid = boxid,sid=sid, log = log , name = name , exp = exp ,verse=verse
; claim the color bar rgb range, from royal blue to orange
cbar = fltarr(3,20)
cbar[0:2,0] = [38,86,163]/255.
cbar[0:2,1] = [47,99,171]/255.
cbar[0:2,2] = [45,128,192]/255.
cbar[0:2,3] = [9,193,238]/255.
cbar[0:2,4] = [92,200,212]/255.
cbar[0:2,5] = [97,194,142]/255.
cbar[0:2,6] = [101,191,100]/255.
cbar[0:2,7] = [104,191,84]/255.
cbar[0:2,8] = [104,191,83]/255.
cbar[0:2,9] = [115,194,83]/255.
cbar[0:2,10] = [126,197,83]/255.

cbar[0:2,11] = [137,200,84]/255.

cbar[0:2,12] = [147,202,84]/255.

cbar[0:2,13] = [193,219,91]/255.

cbar[0:2,14] = [238,235,97]/255.
cbar[0:2,15] = [245,188,74]/255.
cbar[0:2,16] = [252,160,66]/255.
cbar[0:2,17] = [248,123,59]/255.
cbar[0:2,18] = [248,114,50]/255.
cbar[0:2,19] = [248,90,41]/255.

ecolor = [255.,0.,0.]/255.

ecolor2 = [255.,170.,255.]/255.
; rescale the parameter value, first set the min and max, log or not log model
data = odata

if keyword_set(minc) then minc = minc else minc = min(data(3,*))
if keyword_set(maxc) then maxc = maxc else maxc = max(data(3,*))
if keyword_set(verse) then data(3,*) = minc+maxc - data(3,*)
if keyword_set(log) then begin
   data(3,*) = alog10(data(3,*))
   minc = alog10(minc)
   maxc = alog10(maxc) 
endif
if keyword_set(exp) then begin
   data(3,*) = exp(data(3,*))
   minc = exp(minc)
   maxc = exp(maxc) 
endif

; second deal with those with value larger than clmax or less than clmin
w1 = where(data(3,*) lt minc,nw1)
if nw1 gt 0 then data(3,w1) = minc
;w2 = where(data(3,*) gt maxc,nw2)
;if nw2 gt 0 then data(3,w2) = maxc

; now rescale the whole value space into 20 levels
bar = (maxc - minc) / 19.
color = fltarr(3,n_elements(data(0,*)))

w2 = where(data(3,*) gt maxc,nw2)
if nw2 gt 0 then begin 
color(0,w2) = ecolor(0)
color(1,w2) = ecolor(1)
color(2,w2) = ecolor(2)
endif

w3 = where(data(3,*) le maxc,nw3)
data(3,w3) = round( (data(3,w3) - minc)/bar )

color(0:2,w3) = cbar(0:2,data(3,w3))
; write the pov file

if keyword_set(sid) then begin 
color(0,sid) = ecolor2(0)
color(1,sid) = ecolor2(1)
color(2,sid) = ecolor2(2)
endif

mkpov,data(0:2,*),name,radius=r,color=color,boxid = boxid,/margin,/nobox,camera = [47.5779,46.2724,180],/light


end 






