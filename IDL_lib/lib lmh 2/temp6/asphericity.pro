function asphericity,cpdata=cpdata,data=data,nb=nb,dr=dr 

  n = n_elements(cpdata(0,*))
  result = fltarr(2,n)
  start = systime(/seconds)
  for i = 0l,n-1 do begin
  
     nbi = selectnearest(data, cp=cpdata(*,i),rmax=dr, nmax=nb+1)
     nnb = n_elements(nbi(0,*))-1
     result(0,i) = stddev(nbi(0,1:nnb))/mean(nbi(0,1:nnb))
     result(1,i) = nnb
     if i mod 200 eq 0 then begin 
        print, string(i)+ 'Time:' + string(systime(/seconds)-start)  
     endif
  
  endfor
  
  return,result
  
end
     