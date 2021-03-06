; $Id: //depot/idl/IDL_71/idldir/lib/obsolete/itregister.pro#1 $
;
; Copyright (c) 2002-2009, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.
;+
; NAME:
;   itRegister
;
; PURPOSE:
;   A procedural method that allows the user to register an item with
;   the system. This can include tools (the default), visualizations
;   and user interfaces
;
; PARAMETERS
;   strName       - The name to associate with the class
;
;   strClassName  - The class name of the tool or if a UI is being
;                   registered, the routine to call.
;
; Keywords:
;   ANNOTATION: Register an annotation
;
;   FILE_READER: Register a File Reader
;
;   FILE_WRITER: Register a File Writer
;
;   TOOL <default>: Register a tool with the system
;
;   VISUALIZATION: Register a Visualization
;
;   USER_INTERFACE: Register user interface style
;
;   UI_PANEL: Register a UI panel routine and type
;
;   UI_SERVICE: Register a UI service with the system.
;
;   All keywords are passed to the underlying tool registration system.
;
; MODIFICATION HISTORY:
;   Modified: CT, RSI, Jan 2004: Added ANNOTATION, FILE_READER,
;       FILE_WRITER, USER_INTERFACE keywords.
;
;-

;-------------------------------------------------------------------------
PRO itRegister, strName, strClassName, $
                ANNOTATION=annotation, $
                FILE_READER=file_reader, $
                FILE_WRITER=file_writer, $
                VISUALIZATION=visualization, $
                USER_INTERFACE=user_interface, $
                UI_PANEL=ui_panel, $
                UI_SERVICE=ui_service, $
                TOOL=tool, $
                _EXTRA=_EXTRA


   compile_opt hidden, idl2

   iRegister, strName, strClassName, $
              ANNOTATION=annotation, $
              FILE_READER=file_reader, $
              FILE_WRITER=file_writer, $
              VISUALIZATION=visualization, $
              USER_INTERFACE=user_interface, $
              UI_PANEL=ui_panel, $
              UI_SERVICE=ui_service, $
              TOOL=tool, $
              _EXTRA=_EXTRA
                

end


