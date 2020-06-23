pro ozfit,x,A,f,pder
bx=exp(-A[1]*x)/(x^(-0.5))
f=bx*(-x)*A[0]
pder=[[exp(-A[1]*x)/(x^(-0.5))],[bx*(-x)*A[0]]]
end