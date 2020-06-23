; this function aims to calculate local_number_density in z direction, (pay attention: it doesn't use vo cell)
; the final result: finalresult[i,j], i means time period,j means z ztack, finalresult[i,j] means the 
; local_number_density in number j z stack at i period
; there will be some -1 in the finalresult array, which means 缺省值
; if the local number density need smooth, one could smooth parameters. 
; tangshixiang 2015/11/21
function local_number_density,filename,z_length,smooth_array=smooth_array,zmin,zmag
 filename=file_search(filename)
 totalnumber=n_elements(filename)
 zmax=-9999.0
 zmin=9999.0
 for i=0,totalnumber-1 do begin
   bond=read_gdf(filename(i))
   zmax=max([Transpose(bond(2,*)),zmax])
   zmin=min([Transpose(bond(2,*)),zmin])
 endfor
 slides=round((zmax-zmin)/z_length)
 z_stack=(zmax-zmin)/double(slides) 
 finalresult=fltarr(totalnumber,slides)
 print,'zmin=',zmin,'   zmax=',zmax,'   z_stack=',z_stack,'   slides=',slides
 zmag=(zmax-zmin)/slides
 for i=0,totalnumber-1 do begin
   bond=read_gdf(filename(i))
   totalparticle=n_elements(bond(0,*))
   for j=0,slides-1 do begin
     z_begin=zmin+j*z_stack
     z_end=z_begin+z_stack
     w=where(bond(2,*) ge z_begin and bond(2,*) le z_end)
     finalresult(i,j)=(float(n_elements(w))/z_stack)/(totalparticle/(zmax-zmin))
   endfor 
 endfor
 if keyword_set(smooth_array) then finalresult=smooth(finalresult,smooth_array,/edge_truncate)
 return,finalresult
end
;----------------------------------------------------------------------------------------------------------
;array is the result of local_number_density
;there will be some -9999.0 in the finalresult array, which means 缺省值
;tangshixiang 20151121
;
function liquid_layer,array
 array=1-array
 time_period=n_elements(array(*,0))
 z_stack_number=n_elements(array(0,*))
 result=fltarr(2,z_stack_number,time_period)
 finalresult=make_array(time_period,z_stack_number,2,/float,value=-9999.0)
 for i=0,time_period-1 do begin
  t=findgen(z_stack_number)
  result(0,*,i)=t
  result(1,*,i)=array(i,*)
  peak=peak_find(result(*,*,i))
  w=where(peak(1,*) gt 0)        ; in liquid, local number density convergen to, then write it after gt 
  peak1=peak(*,w) 
  peak1_number=n_elements(peak1(0,*))
  for j=0,peak1_number-1 do begin
   finalresult(i,j,0)=peak1(0,j)
   finalresult(i,j,1)=peak1(1,j)
  endfor
 endfor
 return,finalresult
end

;--------------------------------------------------------------------------------------------------------------------
function peak_find,array
totalnumber=n_elements(array(0,*))
j=0
peakarray=make_array(2,totalnumber,/float,value=-9999.0)
if array[1,0] gt array[1,1] then begin 
  peakarray[1,j]=array[1,0]
  peakarray[0,j]=array[0,0]  
  j=j+1
endif
for i=1,totalnumber-2 do begin
  if (array(1,i) ge array(1,i+1) and (array(1,i) gt array(1,i-1))) then begin
    peakarray(1,j)=array(1,i)
    peakarray(0,j)=array(0,i)
    j=j+1
  endif
endfor
if array[totalnumber-1] gt array[totalnumber-2] then begin 
  peakarray[1,j]=array[1,totalnumber-1]  
  peakarray(0,j)=array(0,totalnumber-1)
  j=j+1
endif
w=where(peakarray[1,*] ne -9999.0)
peakarrayresult=peakarray[*,w]
return,peakarrayresult
end

;-----------------------------------------------------------------------------------------

function laypos,filename,z_length,smooarray

re=local_number_density(filename,z_length,smooth_array=smooarray,zmin,zmag)

;the negative process below make the funciton fine the peak rather than the dip, which means u can drop the next process to find the dip 
re=-re

re1=liquid_layer(re)
f1=file_search(filename)
n=n_elements(f1)

all=fltarr(35,n)

;w=where(re1(0,*,0) gt 0)
;all=transpose(re1(0,w,0))

for i=0,n-1 do begin
w=where(re1(i,*,0) gt 0,nw)
temp=transpose(re1(i,w,0))
temp(*)=zmin+temp(*)*zmag
all(0:(nw-1),i)=temp
endfor

return,all
print,n

end




















