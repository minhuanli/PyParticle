;rotate ovec about a fixed axis nn with angle theta
function Rn_theta,ovec=ovec,nn=nn,theta=theta
matrix=fltarr(3,3)
x = nn(0)
y = nn(1)
z = nn(2)
matrix[0,0]=cos(theta)+(1-cos(theta))*x^2
matrix[0,1]=(1-cos(theta))*x*y-sin(theta)*z
matrix[0,2]=(1-cos(theta))*x*z+sin(theta)*y
matrix[1,0]=(1-cos(theta))*y*x+(sin(theta))*z
matrix[1,1]=cos(theta)+(1-cos(theta))*y^2
matrix[1,2]=(1-cos(theta))*y*z-(sin(theta))*x
matrix[2,0]=(1-cos(theta))*z*x-sin(theta)*y
matrix[2,1]=(1-cos(theta))*z*y+(sin(theta)*x)
matrix[2,2]=cos(theta)+(1-cos(theta))*z^2
result = ovec
result(0:2,*)=matrix#ovec(0:2,*)
return,result
end