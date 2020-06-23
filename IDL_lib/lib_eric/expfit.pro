pro expfit,x,A,F,pder
F=A[0]*exp(-x*A[1])
pder=[[exp(-x*A[1])],[-A[0]*x*exp(-x*A[1])]]
end
