function normalq,mpos
q1=0.5*(max(mpos(5,*))+1)/(max(mpos(6,*))+1)
avgstd,mpos(0,*)^2,result
norq1=result(0,*)/q1
return,norq1
end