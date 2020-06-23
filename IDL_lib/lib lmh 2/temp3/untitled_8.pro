start = systime(/second)
bstest = bondvoi(b200s(0:15,*),method=2,dr=4.6,bondmax=12)
print,systime(/second)-start
end