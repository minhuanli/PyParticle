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
