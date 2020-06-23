function rotfai,data,angle

temp=data
temp(0,*)=data(0,*)*cos(angle)+data(1,*)*sin(angle)
temp(1,*)=-data(0,*)*sin(angle)+data(1,*)*cos(angle)

return,temp

end