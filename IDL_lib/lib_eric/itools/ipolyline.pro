; $Id: //depot/idl/IDL_71/idldir/lib/itools/ipolyline.pro#1 $
; Copyright (c) 2002-2009, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.
;+
; NAME:
;   iPolyline
;
; PURPOSE:
;   Adds a polyline annotation to an iTool
;
; CALLING SEQUENCE:
;   iPolyline, points ,ARROW_STYLE=arrowStyle ,ARROW_SIZE=arrowSize $
;                     ,TARGET_IDENTIFIER=target ,IDENTIFIER=id
;
; INPUTS:
;   POINTS - The vertices of the polyline 
;
; KEYWORD PARAMETERS:
;   ARROW_STYLE - The style of arrow used to decorate the line.
;
;   ARROW_SIZE - The size of the displayed arrowhead(s). This keyword
;                only has effect if ARROW_STYLE is set to a value other than 0.
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
PRO iPolyline, pointsIn, $
               VISUALIZATION=visIn, $
               TARGET_IDENTIFIER=ID, $
               TOOL=toolIDin, $
               IDENTIFIER=idOut, $
               _EXTRA=_extra 
  compile_opt hidden, idl2

@idlit_itoolerror.pro

  ;; Set up parameters
  if (KEYWORD_SET(ID)) then begin
    if (SIZE(ID, /TNAME) eq 'STRING') then $
      fullID = iGetID(ID[0], TOOL=toolIDin)
  endif
  if (N_ELEMENTS(fullID) eq 0) then $
    fullID = iGetCurrent()

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
  
  ;; Convert the points
  toVisLayer = KEYWORD_SET(visIn)
  points = iConvertCoord(pointsIn, TO_ANNOTATION_DATA=(~toVisLayer), $
                         TO_DATA=toVisLayer, TARGET_IDENTIFIER=fullID, $
                         TOOL=toolIDin, _EXTRA=_extra)
  ;; If annotation is going into the annotation layer then ensure the Z
  ;; values are as needed
  if (~toVisLayer) then $
    points[2,*] = 0.99d
  
  npoints = (SIZE(points, /DIM))[1]

  ;; Get Manipulator
  oManip=oTool->GetByIdentifier(oTool->FindIdentifiers('*manipulators*line'))
  if (~OBJ_VALID(oManip)) then return

  ;; Temporarily change manipulator name
  oManip->GetProperty, NAME=oldName
  oManip->SetProperty, NAME='Line'
  
  ;; Get Annotation
  oDesc = oTool->GetAnnotation('Line')
  oPolyline = oDesc->GetObjectInstance(_NO_VERTEX_VISUAL=(npoints gt 2))
  
  ;; Set data on annotation
  oPolyline->SetProperty, _DATA=points, _EXTRA=_extra
  oPolyline->SetAxesRequest, 0, /ALWAYS
  
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
      oPolyline->GetProperty, _DATA=points
      points[2,*] = 0.99
      oPolyline->SetProperty, _DATA=points
    endif
    oDS->Add, oPolyline, /NO_UPDATE
  endif else begin
    oWin->Add, oPolyline, LAYER='ANNOTATION'
  endelse
  
  ;; Add to undo/redo buffer
  oManip->CommitAnnotation, oPolyline

  ;; Put old name back  
  oManip->SetProperty, NAME=oldName
  
  ;; Retrieve ID of new line
  if (Arg_Present(idOut)) then $
    idOut = oPolyline->GetFullIdentifier()
  
end
