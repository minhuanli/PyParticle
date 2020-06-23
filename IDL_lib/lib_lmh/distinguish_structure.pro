pro distinguish_structure,bond,abcc=abcc,bfcc=bfcc,chcp=chcp,dbccmicro=dbccmicro,efccmicro=efccmicro,fhcpmicro=fhcpmicro
wa=where(abcc ge 0)
wb=where(bfcc ge 0)
wc=where(chcp ge 0)
wd=where(dbccmicro ge 0)
we=where(efccmicro ge 0)
wf=where(fhcpmicro ge 0)
bcc=bond[*,abcc[wa]]
fcc=bond[*,bfcc[wb]]
hcp=bond[*,chcp[wc]]
bccmicro=bond[*,dbccmicro[wd]]
fccmicro=bond[*,efccmicro[we]]
hcpmicro=bond[*,fhcpmicro[wf]]
bccmicro_bcc=transpose([transpose(bcc),transpose(bccmicro)])
bccmicro_fcc=transpose([transpose(fcc),transpose(bccmicro)])
bccmicro_hcp=transpose([transpose(hcp),transpose(bccmicro)])
fccmicro_bcc=transpose([transpose(bcc),transpose(fccmicro)])
fccmicro_fcc=transpose([transpose(fcc),transpose(fccmicro)])
fccmicro_hcp=transpose([transpose(hcp),transpose(fccmicro)])
hcpmicro_bcc=transpose([transpose(bcc),transpose(hcpmicro)])
hcpmicro_fcc=transpose([transpose(fcc),transpose(hcpmicro)])
hcpmicro_hcp=transpose([transpose(hcp),transpose(hcpmicro)])
density_bccmicro_bcc=hist_2d(bccmicro_bcc[8,*],bccmicro_bcc[5,*],bin1=0.0005,bin2=0.0005,min1=0,max1=0.25,min2=0.25,max2=0.55)
density_bccmicro_fcc=hist_2d(bccmicro_fcc[8,*],bccmicro_fcc[5,*],bin1=0.0005,bin2=0.0005,min1=0,max1=0.25,min2=0.25,max2=0.55)
density_bccmicro_hcp=hist_2d(bccmicro_hcp[8,*],bccmicro_hcp[5,*],bin1=0.0005,bin2=0.0005,min1=0,max1=0.25,min2=0.25,max2=0.55)
density_fccmicro_bcc=hist_2d(fccmicro_bcc[8,*],fccmicro_bcc[5,*],bin1=0.0005,bin2=0.0005,min1=0,max1=0.25,min2=0.25,max2=0.55)
density_fccmicro_fcc=hist_2d(fccmicro_fcc[8,*],fccmicro_fcc[5,*],bin1=0.0005,bin2=0.0005,min1=0,max1=0.25,min2=0.25,max2=0.55)
density_fccmicro_hcp=hist_2d(fccmicro_hcp[8,*],fccmicro_hcp[5,*],bin1=0.0005,bin2=0.0005,min1=0,max1=0.25,min2=0.25,max2=0.55)
density_hcpmicro_bcc=hist_2d(hcpmicro_bcc[8,*],hcpmicro_bcc[5,*],bin1=0.0005,bin2=0.0005,min1=0,max1=0.25,min2=0.25,max2=0.55)
density_hcpmicro_fcc=hist_2d(hcpmicro_fcc[8,*],hcpmicro_fcc[5,*],bin1=0.0005,bin2=0.0005,min1=0,max1=0.25,min2=0.25,max2=0.55)
density_hcpmicro_hcp=hist_2d(hcpmicro_hcp[8,*],hcpmicro_hcp[5,*],bin1=0.0005,bin2=0.0005,min1=0,max1=0.25,min2=0.25,max2=0.55)
write_text,density_bccmicro_bcc,'density_bccmicro_bcc.txt'
write_text,density_bccmicro_fcc,'density_bccmicro_fcc.txt'
write_text,density_bccmicro_hcp,'density_bccmicro_hcp.txt'
write_text,density_fccmicro_bcc,'density_fccmicro_bcc.txt'
write_text,density_fccmicro_fcc,'density_fccmicro_fcc.txt'
write_text,density_fccmicro_hcp,'density_fccmicro_hcp.txt'
write_text,density_hcpmicro_bcc,'density_hcpmicro_bcc.txt'
write_text,density_hcpmicro_fcc,'density_hcpmicro_fcc.txt'
write_text,density_hcpmicro_hcp,'density_hcpmicro_hcp.txt'
end