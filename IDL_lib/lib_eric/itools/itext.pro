; $Id: //depot/idl/IDL_71/idldir/lib/itools/itext.pro#1 $
; Copyright (c) 2002-2009, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.
;+
; NAME:
;   iText
;
; PURPOSE:
;   Adds a text annotation to an iTool
;
; CALLING SEQUENCE:
;   iText, TEXT, X, Y, [Z]
;
; INPUTS:
;   TEXT - The text to add
;
;   X,Y,Z - The location of the text 
;
; KEYWORD PARAMETERS:
;   ORIENTATION - The angle, from horizontal, to rotate the text.  The default
;                 is 0.
;
;   TARGET_IDENTIFIER - The identifier of the view, or itool to annotate. 
;                       If set to an item that is not a view or tool then 
;                       the view that encompasses the defined object will be 
;                       used. If not supplied, the currently selected item 
;                       will be used.
;
;   IDENTIFIER - If set to an named variable, returns the full identifier of 
;                the object created or modified.
;
; MODIFICATION HISTORY:
;   Written by: AGEH, RSI, Jun 2008
;
;-

;-------------------------------------------------------------------------
PRO iText, textIn, xIn, yIn, Zin, $
           ORIENTATION=orientIn, $
           VISUALIZATION=visIn, $
           TARGET_IDENTIFIER=ID, $
           TOOL=toolIDin, $
           UPDIR=updir, $
           BASELINE=baseline, $
           IDENTIFIER=identifier, $
           _EXTRA=_extra 
  compile_opt hidden, idl2

on_error, 2

  catch, err
  if (err ne 0) then begin
    catch, /CANCEL
    if (N_ELEMENTS(oText)) then OBJ_DESTROY, oText
    ; Remove name in front of the error message.
    semi = STRPOS(!ERROR_STATE.msg, ':')
    if (semi gt 0) then !ERROR_STATE.msg = STRMID(!ERROR_STATE.msg, semi+2)
    message, !ERROR_STATE.msg
    return
  endif

  ;; Set up parameters
  if (KEYWORD_SET(ID)) then begin
    if (SIZE(ID, /TNAME) eq 'STRING') then $
      fullID = iGetID(ID[0], TOOL=toolIDin)
  endif
  if (N_ELEMENTS(fullID) eq 0) then $
    fullID = iGetCurrent()

  if (fullID[0] eq '') then begin
    catch, /CANCEL
    message, 'ID not found: '+ID
    return
  endif

  if (N_PARAMS() eq 0) then begin
    catch, /CANCEL
    message, 'Incorrect number of parameters'
    return
  endif
  
  text = STRING(textIn[0])
  x = (N_ELEMENTS(xIn) ne 0) ? DOUBLE(xIn[0]) : 0.5
  y = (N_ELEMENTS(yIn) ne 0) ? DOUBLE(yIn[0]) : 0.9
  z = (N_ELEMENTS(zIn) ne 0) ? DOUBLE(zIn[0]) : 0.0

  ;; Get the system object
  oSystem = _IDLitSys_GetSystem(/NO_CREATE)
  if (~OBJ_VALID(oSystem)) then return

  ;; Get the object from ID
  oObj = oSystem->GetByIdentifier(fullID)
  if (~OBJ_VALID(oObj)) then return
  
  ;; Get the tool
  oTool = oObj->GetTool()
  if (~OBJ_VALID(oTool)) then return
  
  ;; Convert the points
  toVisLayer = KEYWORD_SET(visIn)
  points = iConvertCoord(x, y, z, TO_ANNOTATION_DATA=(~toVisLayer), $
                         TO_DATA=toVisLayer, TARGET_IDENTIFIER=fullID, $
                         TOOL=toolIDin, _EXTRA=_extra)
  ;; If annotation is going into the annotation layer then ensure the Z
  ;; values are as needed.
  if (~toVisLayer) then $
    points[2,*] = 0.99d

  ;; Get Manipulator
  oManip=oTool->GetByIdentifier(oTool->FindIdentifiers('*manipulators*text'))
  if (~OBJ_VALID(oManip)) then return
  
  ;; Get Annotation
  oDesc = oTool->GetAnnotation('Text')
  oText = oDesc->GetObjectInstance()
  
  ;; Set data on annotation
  oText->SetProperty, STRING=text, UPDIR=updir, BASELINE=baseline, $
    VERTICAL_ALIGNMENT=0, _EXTRA=_extra
  oText->SetAxesRequest, 0, /ALWAYS
  
  ;; Rotate text
  if (N_ELEMENTS(orientIn) ne 0) then $
    oText->Rotate, [0,0,1], DOUBLE(orientIn[0])

  ;; Position text
  oText->Translate, points[0], points[1], points[2]

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
    oDS->Add, oText
  endif else begin
    oWin->Add, oText, LAYER='ANNOTATION'
  endelse
  
  ;; Add to undo/redo buffer
  oManip->CommitAnnotation, oText
  
  ;; Retrieve ID of new line
  if (Arg_Present(identifier)) then $
    identifier = oText->GetFullIdentifier()

end
