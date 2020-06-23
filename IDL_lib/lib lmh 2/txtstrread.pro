FUNCTION  txtstrread,file  
  LineCount = FILE_LINES(file);  
  if (LineCount gt 0) then begin  
    StringArray = strarr(LineCount);  
    OPENR, unit, file, /GET_LUN  
    READF, unit, StringArray  
    FREE_LUN, unit  
    FileString=StringArray  
  endif  else begin  
    FileString=''  
    LineCount=0  
  endelse  
  RETURN,FileString  
END  