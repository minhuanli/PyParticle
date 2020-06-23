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

;----------------------------------------------------------
; set the final part as target
function disfield3,data1,data2,idi=idi,timei=timei,typei=typei
   nn = n_elements(data1(0,*))
   res = fltarr(11,nn)
   res(*) = -1.
   k = 0.
   for i = 0, nn-1 do begin 
      w=where(data2(idi,*) eq data1(idi,i),nw)
      if nw eq 0 then continue
      temp = data2(*,w)
      res(0,k) = data1(idi,i)
      res(1,k) = temp(0)
      res(2,k) = temp(1)
      res(3,k) = temp(2)
      res(4,k) = temp(timei)
      res(5,k) = data1(timei,i)
      res(6,k) = - temp(0) + data1(0,i)
      res(7,k) = - temp(1) + data1(1,i)
      res(8,k) = - temp(2) + data1(2,i)
      res(10,k) = data1(typei,i)
      res(9,k) = temp(typei)
      k = k + 1
   endfor
   return,res(*,0:k-1)
end


;----------------------------------------------------------
; use the final part as target 
function disfield2,data1,data2,idi=idi,timei=timei,typei=typei
   nn = n_elements(data1(0,*))
   res = fltarr(11,nn)
   res(*) = -1.
   k = 0.
   for i = 0, nn-1 do begin 
      w=where(data2(idi,*) eq data1(idi,i),nw)
      if nw eq 0 then continue
      temp = data2(*,w)
      res(0,k) = data1(idi,i)
      res(1,k) = data1(0,i)
      res(2,k) = data1(1,i)
      res(3,k) = data1(2,i)
      res(4,k) = data1(timei,i)
      res(5,k) = temp(timei)
      res(6,k) = temp(0) - data1(0,i)
      res(7,k) = temp(1) - data1(1,i)
      res(8,k) = temp(2) - data1(2,i)
      res(9,k) = data1(typei,i)
      res(10,k) = temp(typei)
      k = k + 1
   endfor
   return,res(*,0:k-1)
end

