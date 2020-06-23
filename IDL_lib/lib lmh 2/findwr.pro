;find wr
wr=fltarr(2,100)
j=0
for i=10,100 do begin
 wr(0,j)=i*0.1
 wr(1,j)=-alog(gr(1,j))
 print,i
 j=j+1
 
endfor
end