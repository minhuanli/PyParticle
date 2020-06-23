bp1 = eclip(b,[4,201,400])

bsp1=bondvoi(bp1[1:4,*],dr = 6.0,method=2)

write_gdf,[bsp1,bp1(0,*)],'D:\liminhuan\pre2solid fluc\simudata\0.3tm splitmethod\bsp2.gdf'


bp71 = eclip(b7,[4,201,400])

b7sp1=bondvoi(bp71[1:4,*],dr=6.1,method=2)

write_gdf,[b7sp1,bp71(0,*)],'D:\liminhuan\pre2solid fluc\simudata\0.7tm_splitmethod\b7sp2.gdf'

end