;circulation to calculate every ir for r
;change the n before use
;make sure the gr fucntion start from 0
;change the parameter in the function findir before use
ir=fltarr(2,100)
j=0
n=17912/(((max(a1(0,*)))-(min(a1(0,*))))*((max(a1(1,*)))-(min(a1(1,*))))*((max(a1(2,*)))-(min(a1(2,*)))))
for i=10,100 do begin
 ir(0,j)=i*0.1
 ir(1,j)=findir(i*0.1,20,0,n=n,gr=gr)
 
 print,i
 j=j+1
 
endfor



end