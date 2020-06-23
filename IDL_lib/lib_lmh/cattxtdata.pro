function cattxtdata,filename  
 file = file_search(filename,count=nb)
 print,file(0)
 res = readtext(file(0))
 nn = fltarr(1,n_elements(res(0,*)))
 res = [res,nn] 
 for i = 1, nb-1 do begin 
    print,'No.'+string(i)+':   '+file(i)
    temp = readtext(file(i))
    nn = fltarr(1,n_elements(temp(0,*)))
    nn(0,*) = i 
    temp = [temp,nn]
    res = [[res],[temp]]
 endfor
 
 return,res
end
    