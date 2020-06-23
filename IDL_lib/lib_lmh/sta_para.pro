function sta_para,data,ff,start,finish,bin
;data=plteag
;ff=11
;start=-0.2
;finish=0.1
;bin=0.003
num=fix((finish-start)/bin)
result=fltarr(2,num+1)
for i=0L,num do begin
   temp=start+i*bin
   utemp=temp+bin
   w=where(data(ff,*) ge temp and data(ff,*) lt utemp,nw1)
   result(0,i)=temp
   result(1,i)=nw1
endfor

return,result

end 
   
   
   
     
   