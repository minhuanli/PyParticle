function box_nb,cp=cp,data=data,range
xmin=cp(0)-range(0)
xmax=cp(0)+range(0)
ymin=cp(1)-range(1)
ymax=cp(1)+range(1)
zmin=cp(2)-range(2)
zmax=cp(2)+range(2)
result=eclip(data,[0,xmin,xmax],[1,ymin,ymax],[2,zmin,zmax])
return,result
end