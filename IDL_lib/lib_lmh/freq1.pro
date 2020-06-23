function freq1,data
   data1=data(sort(data))
   temp=data1( uniq(data1) )
   nn=n_elements(temp(*))
   result=fltarr(2,nn)
   for i=0,nn-1 do begin
      result(0,i)=temp(i)
      w=where(data eq temp(i),nw)
      result(1,i)=nw
   endfor
   result=result(*,reverse(sort(result(1,*))))
   return,result
end