nuct= fltarr(4,500)
boo1c= boo1c
for i = 0,499 do begin
print,i
;
bcci1 = eclip(boo1c,[15,i,i],[16,1,1])
bcci2 = eclip(boo1c,[15,i,i],[16,4,4])
bcci = [[bcci1],[bcci2]]
;
hcpi1 = eclip(boo1c,[15,i,i],[16,2,2])
hcpi2 = eclip(boo1c,[15,i,i],[16,5,5])
hcpi = [[hcpi1],[hcpi2]]

fcci1 = eclip(boo1c,[15,i,i],[16,3,3])
fcci2 = eclip(boo1c,[15,i,i],[16,6,6])
fcci = [[fcci1],[fcci2]]


idcluster2,bcci(0:2,*),c01,list=s01,deltar=4.6
nuct(0,i) = i 
nuct(1,i) = max(s01(0,*))
idcluster2,hcpi(0:2,*),c01,list=s01,deltar=4.6
nuc(2,i) = max(s01(0,*))
idcluster2,fcci(0:2,*),c01,list=s01,deltar=4.6
nuc(3,i) = max(s01(0,*))

endfor

end 