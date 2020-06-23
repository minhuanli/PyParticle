; $Id: //depot/idl/IDL_71/idldir/lib/utilities/xsurface.pro#1 $
;
; Copyright (c) 1991-2009, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.
;+
; NAME:
;	XSURFACE
;
; PURPOSE:
;	This routine provides a graphical interface to the SURFACE and
;	SHADE_SURFACE commands.  Different controls are provided to change
;	the viewing angle and other plot parameters.  The command used to
;	generate the resulting surface plot is shown in a text window.
;
; CATEGORY:
;	Widgets.
;
; CALLING SEQUENCE:
;	XSURFACE, Data
;
; INPUT PARAMETERS:
;	Data:	The two-dimensional array to display as a wire-mesh or
;		shaded surface.
;
; KEYWORD PARAMETERS:
;	GROUP:	The widget ID of the widget that calls XSURFACE.  When this
;		keyword is specified, the death of the caller results in the
;		death of XSURFACE.
;
;	BLOCK:  Set this keyword to have XMANAGER block when this
;		application is registered.  By default the Xmanager
;               keyword NO_BLOCK is set to 1 to provide access to the
;               command line if active command 	line processing is available.
;               Note that setting BLOCK for this application will cause
;		all widget applications to block, not only this
;		application.  For more information see the NO_BLOCK keyword
;		to XMANAGER.
;
; SIDE EFFECTS:
;	The XMANAGER is initiated if it is not already running.
;
; RESTRICTIONS:
;	XSURFACE does not accept any of the keywords that the IDL command
;	SURFACE does.
;
; PROCEDURE:
;	Create and register the widget with the XMANAGER and then exit.
;
; MODIFICATION HISTORY:
;	Created from a template written by: Steve Richards, January, 1991.
;-

;------------------------------------------------------------------------------
;	procedure XSurface_draw
;------------------------------------------------------------------------------

PRO XSurface_draw

COMPILE_OPT hidden
COMMON orientation, zrot, thedata, xrot, skirt, shade, axes, thedraw, $
		xmargin, ymargin, upper, commandid

save_win = !D.WINDOW
WSET, thedraw

IF(shade EQ 0) THEN BEGIN
  IF(skirt EQ 0) THEN $
    SURFACE, thedata, $
		XSTYLE = axes, $
		YSTYLE = axes, $
		ZSTYLE = axes, $
		UPPER_ONLY = upper, $
		XMARGIN = xmargin, $
		YMARGIN = ymargin, $
		AZ = zrot, $
		AX = xrot $
  ELSE SURFACE, thedata, $
		XSTYLE = axes, $
		YSTYLE = axes, $
		ZSTYLE = axes, $
		UPPER_ONLY = upper, $
		XMARGIN = xmargin, $
		YMARGIN = ymargin, $
		AZ = zrot, $
		AX = xrot, $
		SKIRT = MIN(thedata,/NAN)
ENDIF ELSE BEGIN
  IF(skirt EQ 0) THEN $
    SHADE_SURF, thedata, $
		XSTYLE = axes, $
		YSTYLE = axes, $
		ZSTYLE = axes, $
		UPPER_ONLY = upper, $
		XMARGIN = xmargin, $
		YMARGIN = ymargin, $
		AZ = zrot, $
		AX = xrot $
    ELSE SHADE_SURF, thedata, $
		XSTYLE = axes, $
		YSTYLE = axes, $
		ZSTYLE = axes, $
		UPPER_ONLY = upper, $
		XMARGIN = xmargin, $
		YMARGIN = ymargin, $
		AZ = zrot, $
		AX = xrot, $
		SKIRT = MIN(thedata,/NAN)
ENDELSE

IF(shade EQ 0) THEN command = "SURFACE, data" $
ELSE command = "SHADE_SURF, data"
IF(xrot NE 30.0) THEN command = command + STRING(xrot, $
					FORMAT = '(", AX = ",I3.3)')
IF(zrot NE 30.0) THEN command = command + STRING(zrot, $
					FORMAT = '(", AZ = ",I3.3)')
IF(skirt NE 0) THEN command = command + ", /SKIRT"
IF(xmargin[0] NE 10.0) THEN $
	command = command + STRING(xmargin, $
	FORMAT = '(", XMARGIN = [",F4.1,", ",F4.1,"]")')
IF(ymargin[0] NE 4.0) THEN $
	command = command + STRING(ymargin, $
	FORMAT = '(", YMARGIN = [",F4.1,", ",F4.1,"]")')
IF(upper NE 0) THEN command = command + ", /UPPER_ONLY"
IF(axes NE 0) THEN command = command + $
	", XSTYLE = 4, YSTYLE = 4, ZSTYLE = 4"

WIDGET_CONTROL, commandid, SET_VALUE = command
WSET, save_win

END


;------------------------------------------------------------------------------
;	procedure XSurface_ev
;------------------------------------------------------------------------------

PRO XSurface_ev, event

COMPILE_OPT hidden
COMMON orientation, zrot, thedata, xrot, skirt, shade, axes, thedraw, $
		xmargin, ymargin, upper, commandid

WIDGET_CONTROL, event.id, GET_UVALUE = eventval		;find the user value
							;of the widget where
							;the event occured
CASE eventval OF

  "       0": BEGIN
		zrot = (zrot + 15) mod 360
		IF(zrot LT 0) THEN zrot = 360 + zrot
		XSurface_draw
		WIDGET_CONTROL, event.id, SET_BUTTON = 0
	      END

  "       1": BEGIN
		zrot = (zrot - 15) mod 360
		IF(zrot LT 0) THEN zrot = 360 + zrot
		XSurface_draw
		WIDGET_CONTROL, event.id, SET_BUTTON = 0
	      END

  "       2": BEGIN
		xrot = (xrot - 15) mod 360
		IF(xrot LT 0) THEN xrot = 360 + xrot
		XSurface_draw
		WIDGET_CONTROL, event.id, SET_BUTTON = 0
	      END

  "       3": BEGIN
		xrot = (xrot + 15) mod 360
		IF(xrot LT 0) THEN xrot = 360 + xrot
		XSurface_draw
		WIDGET_CONTROL, event.id, SET_BUTTON = 0
	      END

  "       4": BEGIN	;shrink
		xmargin = xmargin * 1.2
		ymargin = ymargin * 1.2
		XSurface_draw
		WIDGET_CONTROL, event.id, SET_BUTTON = 0
	      END

  "       5": BEGIN	;grow
		xmargin = xmargin * 0.8
		ymargin = ymargin * 0.8
		XSurface_draw
		WIDGET_CONTROL, event.id, SET_BUTTON = 0
	      END

  "SKIRTON": IF(event.select EQ 1) THEN BEGIN
		skirt = 1
		XSurface_draw
	     ENDIF

  "SKIRTOFF":  IF(event.select EQ 1) THEN BEGIN
		skirt = 0
		XSurface_draw
	      ENDIF

  "SHADEOFF":  IF(event.select EQ 1) THEN BEGIN
		shade = 0
		XSurface_draw
	      ENDIF

  "SHADEON":  IF(event.select EQ 1) THEN BEGIN
		shade = 1
		XSurface_draw
	      ENDIF

  "AXESOFF":  IF(event.select EQ 1) THEN BEGIN
		AXES = 4
		XSurface_draw
	      ENDIF

  "AXESON":  IF(event.select EQ 1) THEN BEGIN
		AXES = 0
		XSurface_draw
	      ENDIF

  "UPPERON": IF(event.select EQ 1) THEN BEGIN
		upper = 0
		XSurface_draw
	      ENDIF

  "UPPEROFF": IF(event.select EQ 1) THEN BEGIN
		upper = 1
		XSurface_draw
	      ENDIF

  "TOOLS": BEGIN
               CASE event.value OF
                   "XLoadct": XLoadct, GROUP = event.top

                   "XPalette": XPalette, GROUP = event.top

                   "XManagerTool": XMTool, GROUP = event.top
               ENDCASE
           END

  "EXIT": WIDGET_CONTROL, event.top, /DESTROY

  ELSE:; MESSAGE, "Event User Value Not Found"

ENDCASE

END ;============= end of XSurface event handling routine task =============



;------------------------------------------------------------------------------
;	procedure XSurface
;------------------------------------------------------------------------------

PRO XSurface, DATA, GROUP = GROUP, BLOCK=block

COMPILE_OPT hidden
COMMON orientation, zrot, thedata, xrot, skirt, shade, axes, thedraw, $
		xmargin, ymargin, upper, commandid

IF(XRegistered("XSurface")) THEN RETURN			;only one instance of
							;the XSurface widget
							;is allowed.  If it is
							;already managed, do
							;nothing and return

IF N_ELEMENTS(block) EQ 0 THEN block=0

save_win = !D.WINDOW
thesize = SIZE(DATA)
zrot = 30.
xrot = 30.
skirt = 0
shade = 0
axes = 0
xmargin = [10.0, 3.0]
ymargin = [4.0, 2.0]
upper = 0
commandid = 0L

XSurfacebase = WIDGET_BASE(TITLE = "XSurface", $
		/COLUMN)
; This is a little tricky. Setting the managed attribute indicates
; our intention to put this app under the control of XMANAGER, and
; prevents our draw widgets from becoming candidates for becoming
; the default window on WSET, -1. XMANAGER sets this, but doing it here
; prevents our own WSETs at startup from having that problem.
WIDGET_CONTROL, /MANAGED, XSurfacebase

menubase = WIDGET_BASE(XSurfacebase, /ROW)
donebutton = WIDGET_BUTTON(menubase, VALUE='Done', UVALUE='EXIT')
toolsmenu = CW_PDMENU(menubase, ['1\Tools', $
                                 '0\XLoadct', $
                                 '0\XPalette', $
                                 '2\XManagerTool'], UVALUE='TOOLS', $
                                 /RETURN_NAME)

thebase = WIDGET_BASE(XSurfacebase, /ROW)

ver	= widget_info(/version)
case ver.style OF
'OPEN LOOK': BEGIN
	  XSurfacepalette = WIDGET_BASE(thebase, $
				/COLUMN, $
				/FRAME, $
				/EXCLUSIVE)
	END
ELSE:	    BEGIN
	  XSurfacepalette = WIDGET_BASE(thebase, $
				/COLUMN, $
				/FRAME)
	END
ENDCASE

controls = [							$
		[						$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 248B, 255B, 063B, 000B],			$
		[128B, 007B, 000B, 224B, 001B],			$
		[112B, 000B, 000B, 000B, 014B],			$
		[136B, 000B, 016B, 000B, 016B],			$
		[052B, 000B, 048B, 000B, 056B],			$
		[172B, 000B, 080B, 000B, 032B],			$
		[124B, 000B, 144B, 000B, 040B],			$
		[164B, 007B, 016B, 001B, 048B],			$
		[012B, 248B, 031B, 062B, 056B],			$
		[036B, 000B, 000B, 228B, 033B],			$
		[004B, 000B, 000B, 008B, 062B],			$
		[012B, 000B, 000B, 016B, 048B],			$
		[036B, 000B, 000B, 016B, 032B],			$
		[008B, 000B, 000B, 008B, 000B],			$
		[112B, 000B, 000B, 004B, 000B],			$
		[128B, 007B, 000B, 002B, 000B],			$
		[000B, 248B, 031B, 001B, 000B],			$
		[000B, 000B, 144B, 000B, 000B],			$
		[000B, 000B, 080B, 000B, 000B],			$
		[000B, 000B, 048B, 000B, 000B],			$
		[000B, 000B, 016B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B]			$
		],						$
;		dnz.bmdef
		[						$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 252B, 255B, 031B, 000B],			$
		[128B, 007B, 000B, 224B, 001B],			$
		[112B, 000B, 000B, 000B, 014B],			$
		[008B, 000B, 008B, 000B, 017B],			$
		[028B, 000B, 012B, 000B, 044B],			$
		[004B, 000B, 010B, 000B, 053B],			$
		[020B, 000B, 009B, 000B, 062B],			$
		[012B, 128B, 008B, 224B, 037B],			$
		[028B, 124B, 248B, 031B, 048B],			$
		[132B, 039B, 000B, 000B, 036B],			$
		[124B, 016B, 000B, 000B, 032B],			$
		[012B, 008B, 000B, 000B, 048B],			$
		[004B, 008B, 000B, 000B, 036B],			$
		[000B, 016B, 000B, 000B, 016B],			$
		[000B, 032B, 000B, 000B, 014B],			$
		[000B, 064B, 000B, 224B, 001B],			$
		[000B, 128B, 248B, 031B, 000B],			$
		[000B, 000B, 009B, 000B, 000B],			$
		[000B, 000B, 010B, 000B, 000B],			$
		[000B, 000B, 012B, 000B, 000B],			$
		[000B, 000B, 008B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B]			$
		],						$
		;upz.bm
		[						$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 128B, 255B, 001B, 000B],			$
		[000B, 064B, 169B, 002B, 000B],			$
		[000B, 160B, 254B, 007B, 000B],			$
		[000B, 160B, 068B, 000B, 000B],			$
		[000B, 016B, 032B, 000B, 000B],			$
		[000B, 016B, 032B, 000B, 000B],			$
		[000B, 016B, 032B, 000B, 000B],			$
		[000B, 016B, 032B, 000B, 000B],			$
		[000B, 008B, 016B, 000B, 000B],			$
		[000B, 008B, 016B, 000B, 000B],			$
		[000B, 008B, 144B, 001B, 000B],			$
		[000B, 008B, 112B, 006B, 000B],			$
		[000B, 008B, 016B, 008B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 006B, 096B, 000B],			$
		[000B, 008B, 001B, 128B, 000B],			$
		[000B, 136B, 000B, 000B, 001B],			$
		[000B, 200B, 015B, 240B, 003B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 016B, 004B, 008B, 000B],			$
		[000B, 016B, 004B, 008B, 000B],			$
		[000B, 016B, 005B, 008B, 000B],			$
		[000B, 080B, 004B, 008B, 000B],			$
		[000B, 032B, 147B, 004B, 000B],			$
		[000B, 160B, 042B, 005B, 000B],			$
		[000B, 064B, 149B, 002B, 000B],			$
		[000B, 128B, 255B, 001B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B]			$
		],						$
		;dnx.bm
		[						$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 128B, 255B, 001B, 000B],			$
		[000B, 064B, 149B, 002B, 000B],			$
		[000B, 160B, 042B, 005B, 000B],			$
		[000B, 032B, 147B, 004B, 000B],			$
		[000B, 080B, 004B, 008B, 000B],			$
		[000B, 016B, 005B, 008B, 000B],			$
		[000B, 016B, 004B, 008B, 000B],			$
		[000B, 016B, 004B, 008B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 200B, 015B, 240B, 003B],			$
		[000B, 136B, 000B, 000B, 001B],			$
		[000B, 008B, 001B, 128B, 000B],			$
		[000B, 008B, 006B, 096B, 000B],			$
		[000B, 008B, 008B, 016B, 000B],			$
		[000B, 008B, 016B, 008B, 000B],			$
		[000B, 008B, 112B, 006B, 000B],			$
		[000B, 008B, 144B, 001B, 000B],			$
		[000B, 008B, 016B, 000B, 000B],			$
		[000B, 008B, 016B, 000B, 000B],			$
		[000B, 016B, 032B, 000B, 000B],			$
		[000B, 016B, 032B, 000B, 000B],			$
		[000B, 016B, 032B, 000B, 000B],			$
		[000B, 016B, 032B, 000B, 000B],			$
		[000B, 160B, 068B, 000B, 000B],			$
		[000B, 160B, 254B, 007B, 000B],			$
		[000B, 064B, 169B, 002B, 000B],			$
		[000B, 128B, 255B, 001B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B]			$
		],						$
		;shrink.bm
		[						$
		[000B, 000B, 008B, 000B, 000B],			$
		[000B, 000B, 008B, 000B, 000B],			$
		[000B, 000B, 073B, 000B, 000B],			$
		[000B, 000B, 042B, 000B, 000B],			$
		[000B, 000B, 028B, 000B, 000B],			$
		[000B, 000B, 008B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[128B, 255B, 255B, 255B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[132B, 000B, 000B, 000B, 033B],			$
		[136B, 000B, 000B, 000B, 017B],			$
		[144B, 000B, 000B, 000B, 009B],			$
		[191B, 000B, 000B, 000B, 253B],			$
		[144B, 000B, 000B, 000B, 009B],			$
		[136B, 000B, 000B, 000B, 017B],			$
		[132B, 000B, 000B, 000B, 033B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 000B, 000B, 000B, 001B],			$
		[128B, 255B, 255B, 255B, 001B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 008B, 000B, 000B],			$
		[000B, 000B, 028B, 000B, 000B],			$
		[000B, 000B, 042B, 000B, 000B],			$
		[000B, 000B, 073B, 000B, 000B],			$
		[000B, 000B, 008B, 000B, 000B],			$
		[000B, 000B, 008B, 000B, 000B]			$
		],						$
		;grow.bm
		[						$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[248B, 255B, 255B, 255B, 031B],			$
		[008B, 000B, 000B, 000B, 016B],			$
		[008B, 000B, 008B, 000B, 016B],			$
		[008B, 000B, 028B, 000B, 016B],			$
		[008B, 000B, 042B, 000B, 016B],			$
		[008B, 000B, 073B, 000B, 016B],			$
		[008B, 000B, 008B, 000B, 016B],			$
		[008B, 000B, 008B, 000B, 016B],			$
		[008B, 000B, 008B, 000B, 016B],			$
		[008B, 000B, 008B, 000B, 016B],			$
		[008B, 000B, 008B, 000B, 016B],			$
		[008B, 000B, 000B, 000B, 016B],			$
		[008B, 000B, 000B, 000B, 016B],			$
		[008B, 001B, 000B, 000B, 016B],			$
		[136B, 000B, 000B, 128B, 016B],			$
		[072B, 000B, 000B, 000B, 017B],			$
		[232B, 063B, 000B, 000B, 018B],			$
		[072B, 000B, 000B, 252B, 023B],			$
		[136B, 000B, 000B, 000B, 018B],			$
		[008B, 001B, 000B, 000B, 017B],			$
		[008B, 000B, 000B, 128B, 016B],			$
		[008B, 000B, 000B, 000B, 016B],			$
		[008B, 000B, 000B, 000B, 016B],			$
		[008B, 000B, 000B, 000B, 016B],			$
		[008B, 000B, 016B, 000B, 016B],			$
		[008B, 000B, 016B, 000B, 016B],			$
		[008B, 000B, 016B, 000B, 016B],			$
		[008B, 000B, 016B, 000B, 016B],			$
		[008B, 000B, 146B, 000B, 016B],			$
		[008B, 000B, 084B, 000B, 016B],			$
		[008B, 000B, 056B, 000B, 016B],			$
		[008B, 000B, 016B, 000B, 016B],			$
		[008B, 000B, 000B, 000B, 016B],			$
		[248B, 255B, 255B, 255B, 031B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B],			$
		[000B, 000B, 000B, 000B, 000B]			$
		]						$
	   ]

FOR i = 0,N_ELEMENTS(controls[0,0,*])-1 DO $
  toss = WIDGET_BUTTON(XSurfacepalette, $
		VALUE = controls[*,*,i], $
		UVALUE = STRING(i))

XSurfacedisplay = WIDGET_DRAW(thebase, $
		XSIZE = 375, $
		YSIZE = 300, $
		RETAIN = 2)

XSurfacecontrols = WIDGET_BASE(XSurfacebase, $
		/ROW)

skirtbase = WIDGET_BASE(XSurfacecontrols, $
		/COLUMN, $
		/EXCLUSIVE, $
		/FRAME)

skirtoff = WIDGET_BUTTON(skirtbase, $
		VALUE = "No Skirt", $
		UVALUE = "SKIRTOFF")

skirton = WIDGET_BUTTON(skirtbase, $
		VALUE = "Skirt", $
		UVALUE = "SKIRTON")

shadebase = WIDGET_BASE(XSurfacecontrols, $
		/COLUMN, $
		/EXCLUSIVE, $
		/FRAME)

shadeoff = WIDGET_BUTTON(shadebase, $
		VALUE = "Wire Frame", $
		UVALUE = "SHADEOFF")

shadeon = WIDGET_BUTTON(shadebase, $
		VALUE = "Shaded Surface", $
		UVALUE = "SHADEON")


axesbase = WIDGET_BASE(XSurfacecontrols, $
		/COLUMN, $
		/EXCLUSIVE, $
		/FRAME)

axeson = WIDGET_BUTTON(axesbase, $
		VALUE = "Show Axes", $
		UVALUE = "AXESON")

axesoff = WIDGET_BUTTON(axesbase, $
		VALUE = "Hide Axes", $
		UVALUE = "AXESOFF")

upperbase = WIDGET_BASE(XSurfacecontrols, $
		/COLUMN, $
		/EXCLUSIVE, $
		/FRAME)

upperon = WIDGET_BUTTON(upperbase, $
		VALUE = "Show Top and Bottom", $
		UVALUE = "UPPERON")

upperoff = WIDGET_BUTTON(upperbase, $
		VALUE = "Only Show Top", $
		UVALUE = "UPPEROFF")

commandbase = WIDGET_BASE(XSurfacebase, $
		/FRAME, $
		/COLUMN)

commandlabel = WIDGET_LABEL(commandbase, $
		VALUE = "IDL Commmand To Produce Above Output:")

case ver.style of
'OPEN LOOK':  commandid = WIDGET_LABEL(commandbase, VALUE = "SURFACE, data")
ELSE:	      commandid = WIDGET_TEXT(commandbase, $
				VALUE = "SURFACE, data", $
				/SCROLL, $
				YSIZE = 1)
ENDCASE

WIDGET_CONTROL, XSurfacebase, /REALIZE			;create the widgets
							;that is defined

WIDGET_CONTROL, skirtoff, /SET_BUTTON
WIDGET_CONTROL, shadeoff, /SET_BUTTON
WIDGET_CONTROL, axeson, /SET_BUTTON
WIDGET_CONTROL, upperon, /SET_BUTTON
WIDGET_CONTROL, XSurfacedisplay, GET_VALUE = temp & thedraw = temp

IF(N_PARAMS() gt 0) THEN BEGIN
	thedata = DATA
	XSurface_draw
END

WSET, SAVE_WIN
XManager, "XSurface", XSurfacebase, $			;register the widgets
		EVENT_HANDLER = "XSurface_ev", $	;with the XManager
		GROUP_LEADER = GROUP, NO_BLOCK=(NOT(FLOAT(block)))

END ;================ end of XSurface background task =====================



