kick = [[kick1],[kick2],[kick3],[kick4],[kick5],[kick6],[kick7]]
test = kickdata(test,kick)
write_text,test,'D:\liminhuan\s-s transition project\1105 data\figure2_test\0min18\test.txt'
 povlmh_color,[test(0:2,*),test(8,*)],r = 0.94, minc=-0.015,maxc = 0.00001 ,name ='D:\liminhuan\s-s transition project\1105 data\figure2_test\0min18\'+ 'test.pov'