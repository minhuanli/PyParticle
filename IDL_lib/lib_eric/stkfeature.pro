pro stkfeature,filename
f1=findfile(filename)
n1=n_elements(f1)
for j=0,n1-1 do begin
ept3d,f1[j],bplo=[1,1,1],bphi=[3,3,4],dia=[6,6,8],sep=[6,6,8],/gdf
endfor
end