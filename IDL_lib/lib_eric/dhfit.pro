pro dhfit,x,A,f,pder
m1=(x^2-A[0]^2)^2+x^2*(A[1]^2)
dfa=A[2]*(2*A[0]*A[1]*m1+4*A[0]^3*A[1]*(x^2-A[1]^2))/(m1^2)
dfb=A[2]*(A[0]^2*m1-2*A[0]^2*A[1]^2*x^2)/(m1^2)
dfc=A[0]^2*A[1]/m1
f=A[2]*(A[0]^2)*A[1]/m1
pder=[[dfa],[dfb],[dfc]]
end