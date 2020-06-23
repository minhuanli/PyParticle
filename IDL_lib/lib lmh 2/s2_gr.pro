function s2_gr,gr=gr,rou0=rou0
  g03 = gr(1,*)
  r1 = gr(0,*)
  deltar = gr(0,1)-gr(0,0) ; radius delta 
  g04 = (g03*alog(g03)-g03+1)*4.0*!pi*r1*r1*deltar
  res = -0.5*total(g04)*rou0
  return,res
end