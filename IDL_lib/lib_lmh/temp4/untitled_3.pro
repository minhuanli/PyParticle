list = [0,5,22,47,88]
name = ['t0','t5','t22','t47','t88']
for i = 0,4 do begin
  typeai = eclip(typea,[16,list(i),list(i)])
  typebi = eclip(typeb,[16,list(i),list(i)]) 
  ; nblist
;  plot_hist,typeai(14,*),bin=0.5,nblista
;  nblista(1,*) = nblista(1,*) / n_elements(typeai(0,*))
;  plot_hist,typebi(14,*),bin=0.5,nblistb
;  nblistb(1,*) = nblistb(1,*) / n_elements(typebi(0,*))
  ;voronoi cell volume
  plot_hist,typeai(12,*),bin=0.015,vva
  vva(1,*) = vva(1,*) / n_elements(typeai(0,*))
  plot_hist,typebi(12,*),bin=0.015,vvb
  vvb(1,*) = vvb(1,*) / n_elements(typebi(0,*))
  
;  write_text,nblista,'D:\liminhuan\teag_project\quasicrystal\figure5_nblist_localdensity\'+name(i)+'_nblista.txt'
;  write_text,nblistb,'D:\liminhuan\teag_project\quasicrystal\figure5_nblist_localdensity\'+name(i)+'_nblistb.txt'
  write_text,smooth(vva,[1,3]),'D:\liminhuan\teag_project\quasicrystal\figure5_nblist_localdensity\distribution_text\'+name(i)+'_vva.txt'
  write_text,smooth(vvb,[1,3]),'D:\liminhuan\teag_project\quasicrystal\figure5_nblist_localdensity\distribution_text\'+name(i)+'_vvb.txt'
endfor

end