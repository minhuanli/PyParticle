function disfield,data,tgdata,idi=idi,timei=timei
   nn = n_elements(tgdata(0,*))
   res = fltarr(9,nn)
   res(*) = -1.
   for i = 0, nn-1 do begin 
      w=where(data(idi,*) eq tgdata(idi,i),nw)
      if nw lt 10 then continue
      temp = data(*,w)
      res(0,i) = mean(temp(0,*))
      res(1,i) = mean(temp(1,*))
      res(2,i) = mean(temp(2,*))
      res(6,i) = min(temp(timei,*))
      res(7,i) = max(temp(timei,*))
      res(8,i) = tgdata(idi,i)
      res(3,i) = mean(temp(0,nw-10:nw-1)) - mean(temp(0,0:9))
      res(4,i) = mean(temp(1,nw-10:nw-1)) - mean(temp(1,0:9))
      res(5,i) = mean(temp(2,nw-10:nw-1)) - mean(temp(2,0:9))
   endfor
   return,res
end