PRO yukawa, x, A, F, pder 
  bx = A[0]*exp(-A[1]*(x-2)) 
  F = bx/(x/2)
 
;If the procedure is called with four parameters, calculate the 
;partial derivatives. 
  
    pder = [[bx/A[0]/(x/2)],[bx*(2-x)/(x/2)]] 
END 
