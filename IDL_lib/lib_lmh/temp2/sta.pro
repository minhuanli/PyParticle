file1 = file_search('D:\liminhuan\s-s transition project\1003 data\lindemann res\before\p1lin*') ;before sub 3d x y z 
file23d = file_search('D:\liminhuan\s-s transition project\1003 data\lindemann res\after\pos1\p1res3d*')
file2x = file_search('D:\liminhuan\s-s transition project\1003 data\lindemann res\after\pos1\p1resx*')
file2y = file_search('D:\liminhuan\s-s transition project\1003 data\lindemann res\after\pos1\p1resy*')
file2z = file_search('D:\liminhuan\s-s transition project\1003 data\lindemann res\after\pos1\p1resz*')

res = fltarr(4,12)

lin03d = readtext(file1(0))
lin0x = readtext(file1(1))
lin0y = readtext(file1(2))
lin0z = readtext(file1(3))

temp = gaussfit(lin03d(0,*),lin03d(1,*),coeff,nt=3)
res(0,0) = coeff(1)
temp = gaussfit(lin0x(0,*),lin0x(1,*),coeff,nt=3)
res(1,0) = coeff(1)
temp = gaussfit(lin0y(0,*),lin0y(1,*),coeff,nt=3)
res(2,0) = coeff(1)
temp = gaussfit(lin0z(0,*),lin0z(1,*),coeff,nt=3)
res(3,0) = coeff(1)


for i = 0, 10 do begin 

lin03d = readtext(file23d(i))
lin0x = readtext(file2x(i))
lin0y = readtext(file2y(i))
lin0z = readtext(file2z(i))

temp = gaussfit(lin03d(0,*),lin03d(1,*),coeff,nt=3)
res(0,i+1) = coeff(1)
temp = gaussfit(lin0x(0,*),lin0x(1,*),coeff,nt=3)
res(1,i+1) = coeff(1)
temp = gaussfit(lin0y(0,*),lin0y(1,*),coeff,nt=3)
res(2,i+1) = coeff(1)
temp = gaussfit(lin0z(0,*),lin0z(1,*),coeff,nt=3)
res(3,i+1) = coeff(1)

endfor

end