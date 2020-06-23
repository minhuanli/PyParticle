function idnearby,data,id1,deltar=deltar
;n1=n_elements(data(0,*))
dm1=conmatrix(data,deltar=deltar)
id2=idshell(dm1,id1)
return,id2
end