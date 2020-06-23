; i worte this just to save some time on generating the distribution after plothist process; including dropping off the negtive part
function hist_lmh,data,bin=bin
  plot_hist,data,bin=bin,res
  w=where(res(0,*) gt 0 and res(1,*) gt 0)
  res(0,*) = res(0,*) * 3.5
  res= res(*,w)
  
  return,res

end