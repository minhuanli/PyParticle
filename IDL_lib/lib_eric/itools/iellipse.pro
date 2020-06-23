; $Id: //depot/idl/IDL_71/idldir/lib/itools/iellipse.pro#1 $
; Copyright (c) 2002-2009, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.
;+
; NAME:
;   iEllipse
;
; PURPOSE:
;   Adds a Ellipse annotation to an iTool
;
; CALLING SEQUENCE:
;   iEllipse, x, y, a [, e [, theta]] [,VISUALIZATION=target] [,IDENTIFIER=id]
;
; INPUTS:
;   X, Y - The center point of the ellipse.
;
;   A - The length of the semi-major axis
;
;   e - The eccentricity of the ellipse, defined as SQRT(a^2 - b^2) / a where
;       a is the length of the semi-major axis and b is the length of the 
;       semi-minor axis. If not supplied, a default of 0, denoting a circle, 
;       is used.
;
;   THETA - The angle, counter-clockwise from horizontal, of the semi-major 
;           axis. If not supplied, a default of 0 is used.
;
; KEYWORD PARAMETERS:
;   VISUALIZATION - If set, add the annotation to the data space.  The default
;                   is to add it to the annotation layer.  VISUALIZATION is the
;                   identifier of the view, or itool to annotate.  If set to 
;                   an item that is not a view or tool then the view that
;                   encompasses the defined object will be used. If not 
;                   supplied, the currently selected item will be used.
;
;   IDENTIFIER - If set to an named variable, returns the full identifier of 
;                the object created or modified.
;                
; MODIFICATION HISTORY:
;   Written by: AGEH, RSI, Jun 2008
;
;-

PRO iEllipse, majorIn, xcIn, ycIn, zcIn, $
              ECCENTRICITY=eccIn, $
              THETA=thetaIn, $
              DATA=dataIn, $
              VISUALIZATION=visIn, $
              TARGET_IDENTIFIER=ID, $
              TOOL=toolIDin, $
              IDENTIFIER=idOut, $
              _EXTRA=_extra 
  compile_opt hidden, idl2

ON_ERROR, 2

  if (N_PARAMS() lt 3) then begin
    message, 'Incorrect number of parameters'
    return
  endif
  
  ;; Set up parameters
  if (KEYWORD_SET(ID)) then begin
    if (SIZE(ID, /TNAME) eq 'STRING') then $
      fullID = iGetID(ID[0], TOOL=toolIDin)
  endif
  if (N_ELEMENTS(fullID) eq 0) then $
    fullID = iGetCurrent()

  xc = DOUBLE(xcIn[0])
  yc = DOUBLE(ycIn[0])
  zc = N_ELEMENTS(zcIn) eq 0 ? 0.0d : DOUBLE(zcIn[0])
  major = DOUBLE(majorIn[0])
  ecc = N_ELEMENTS(eccIn) eq 0 ? 0.0d : 0.0d > DOUBLE(eccIn[0] < 1.0d)
  case N_ELEMENTS(thetaIn) of
    3 : theta = DOUBLE(thetaIn)
    1 : theta = [0.0d, 0.0d, DOUBLE(thetaIn)]
    else : theta = [0.0d, 0.0d, 0.0d]
  endcase
  
  ;; Switch from left hand rotation matrix to right hand grModel
  theta *= -1.0d

  ;; Error checking
  if (fullID[0] eq '') then begin
    message, 'Target not found: '+ID
    return
  endif

  ;; Get the system object
  oSystem = _IDLitSys_GetSystem(/NO_CREATE)
  if (~OBJ_VALID(oSystem)) then return

  ;; Get the object from ID
  oObj = oSystem->GetByIdentifier(fullID)
  if (~OBJ_VALID(oObj)) then return
  
  ;; Get the tool
  oTool = oObj->GetTool()
  if (~OBJ_VALID(oTool)) then return
  
  ;; Math stuff
  minor = SQRT(major^2 - (major*ecc)^2)
  tm = FINDGEN(181)/180. ;; 180 seems like a good number of points
  x = major*COS(2*!pi*tm)
  y = minor*SIN(2*!pi*tm)
  r = SQRT(x^2+y^2)
  
  th = ATAN(y,x)

  xx = r*COS(th)
  yy = r*SIN(th)
  zz = r*0.0
  
  theta *= !dtor

  transx = [[1, 0, 0], $
           [0, cos(theta[0]), -sin(theta[0])], $
           [0, sin(theta[0]), cos(theta[0])]] 
  transy = [[cos(theta[1]), 0, sin(theta[1])], $
           [0, 1, 0], $
           [-sin(theta[1]), 0, cos(theta[1])]] 
  transz = [[cos(theta[2]), -sin(theta[2]), 0], $
           [sin(theta[2]), cos(theta[2]), 0], $
           [0, 0, 1]] 
  
  for i=0,N_ELEMENTS(xx)-1 do begin
    point = [xx[i], yy[i], zz[i]]
    newPoint = transx#point
    newPoint = transy#newPoint
    newPoint = transz#newPoint
    xx[i] = newPoint[0]
    yy[i] = newPoint[1]
    zz[i] = newPoint[2]
  endfor

  xx += xc
  yy += yc
  zz += zc
  
  ;; Convert the points
  toVisLayer = KEYWORD_SET(visIn)
  points = iConvertCoord(xx, yy, zz, TO_ANNOTATION_DATA=(~toVisLayer), $
                         TO_DATA=toVisLayer, DATA=dataIn, $
                         TARGET_IDENTIFIER=fullID, TOOL=toolIDin, $
                         _EXTRA=_extra)
  ;; If annotation is going into the annotation layer then ensure the Z
  ;; values are as needed.
  if (~toVisLayer) then $
    points[2,*] = 0.99d

  ;; Get Manipulator
  oManip = oTool->GetByIdentifier(oTool->FindIdentifiers('*manipulators*oval'))
  if (~OBJ_VALID(oManip)) then return

  ;; Temporarily change manipulator name
  oManip->GetProperty, NAME=oldName
  oManip->SetProperty, NAME='Ellipse'
  
  ;; Get Annotation
  oDesc = oTool->GetAnnotation('Oval')
  oEllipse = oDesc->GetObjectInstance()
  
  ;; Set data on annotation
  oEllipse->SetProperty, _DATA=points, _EXTRA=_extra
  oEllipse->SetAxesRequest, 0, /ALWAYS
  
  ;; Add annotation to proper layer in the window
  oWin = oTool->GetCurrentWindow()
  if (toVisLayer) then begin
    ;; Add to data space
    if (OBJ_HASMETHOD(oObj, 'GetDataSpace')) then begin
      oDS = oObj->GetDataSpace()
    endif else begin
      ;; The view does not have a getdataspace method
      if (OBJ_ISA(oObj, 'IDLitgrView')) then begin
        dsID = (oObj->FindIdentifiers('*DATA SPACE*'))[0]
      endif else begin
        ;; Fall back to finding first data space in the window
        dsID = oWin->FindIdentifiers('*Data Space')
      endelse
      oDS = oSystem->GetByIdentifier(dsID)
    endelse
    ;; If dataspace is 2D then put annotation on top
    if (~oDS->is3D()) then begin
      oEllipse->GetProperty, _DATA=points
      points[2,*] = 0.99
      oEllipse->SetProperty, _DATA=points
    endif
    oDS->Add, oEllipse
  endif else begin
    oWin->Add, oEllipse, LAYER='ANNOTATION'
  endelse
  
  ;; Add to undo/redo buffer
  oManip->CommitAnnotation, oEllipse

  ;; Put old name back  
  oManip->SetProperty, NAME=oldName

  ;; Retrieve ID of new line
  if (Arg_Present(idOut)) then $
    idOut = oEllipse->GetFullIdentifier()
  
end
