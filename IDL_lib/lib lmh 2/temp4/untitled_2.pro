
for i = 0,99 do begin

  test = eclip(bc,[16,i,i],[2,25,40])
  testa12 = eclip(typea12,[16,i,i],[2,25,40])
  testb15 = eclip(typeb15,[16,i,i],[2,25,40])
  povlmh3,test,testb15,testa12,0.01,0.5,0.5,'D:\liminhuan\teag_project\quasicrystal\figure4_real_sapce\povray\pov'+string(i)+'.pov'
  
endfor
  
end