pro trainsetprep,bg=bg,data1,data2,data3,size=size,range=range,fname=fname
  
  n1=n_elements(data1(0,*))
  n2=n_elements(data2(0,*))
  n3=n_elements(data3(0,*))
  ;indice1=fix(randomu(undefinevar,size))*n1
  ;indice2=fix(randomu(undefinevar,size))*n2
  ;indice3=fix(randomu(undefinevar,size))*n3
  ;indice=indgen(1,size)
  train1=pixel_boxall(cp=data1(*,8000:8599),bg=bg,xrange=range,yrange=range,zrange=range)
  train2=pixel_boxall(cp=data2(*,8000:8599),bg=bg,xrange=range,yrange=range,zrange=range)
  train3=pixel_boxall(cp=data3(*,8000:8599),bg=bg,xrange=range,yrange=range,zrange=range)
  train = [[train1],[train2],[train3]]
  write_tiff,fname,train
  
end
  