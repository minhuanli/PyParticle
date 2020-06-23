pro ozfit2d, x,A,F,pder
F=A[0]*x^(-0.25)*exp(-x*A[1])
pder=[[(x^(-0.25))*exp(-x*A[1])],[-A[0]*x*(x^(-0.25))*exp(-x*A[1])]]
end