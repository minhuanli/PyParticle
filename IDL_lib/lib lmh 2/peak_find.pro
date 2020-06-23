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