function faceadj,tetra1,tetra2
adj=0
tetra1=tetra1[0:3]
tetra2=tetra2[0:3]
tetra3=[tetra1,tetra2]
na=n_elements(tetra3[uniq(tetra3,sort(tetra3))])
if na eq 5 then adj=1
if na eq 6 then adj=-1
return,adj
end
