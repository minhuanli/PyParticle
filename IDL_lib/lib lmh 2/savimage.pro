PRO saveimage, windowID, windowDims, imageFile,type=type
  ;top the target window
  WSET,windowID
  ;copy the screen
  data = TVRD(0,0,windowDims[0],windowDims[1],/true)
  CASE type OF
    1: WRITE_JPEG, imageFile, data,/true, quality=10000
    2: WRITE_BMP,imageFIle,data,/RGB
    3: WRITE_TIFF,imageFile, data,ORIENTATION =4
    4: write_png,imagefile,data
    ELSE:
  ENDCASE
 
END
