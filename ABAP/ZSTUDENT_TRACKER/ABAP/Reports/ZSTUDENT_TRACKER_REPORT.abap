REPORT zstudent_tracker_report.

*---------------------------------------------------------------------*
* Student Study and Assignment Tracker
*---------------------------------------------------------------------*

TYPES: BEGIN OF ty_assignment,
         id         TYPE n LENGTH 6,
         subject    TYPE char20,
         assignment TYPE char40,
         deadline   TYPE d,
         status     TYPE char20,
         studyhours TYPE p LENGTH 5 DECIMALS 2,
       END OF ty_assignment.

DATA: gt_assignment TYPE STANDARD TABLE OF ty_assignment,
      gs_assignment TYPE ty_assignment.

DATA: gt_display TYPE STANDARD TABLE OF ty_assignment,
      gs_display TYPE ty_assignment.

DATA: gv_total     TYPE i,
      gv_completed TYPE i,
      gv_pending   TYPE i,
      gv_overdue   TYPE i,
      gv_percent   TYPE p LENGTH 5 DECIMALS 0,
      gv_hours     TYPE p LENGTH 8 DECIMALS 2.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

PARAMETERS:
  p_all  RADIOBUTTON GROUP g1 DEFAULT 'X',
  p_pend RADIOBUTTON GROUP g1,
  p_comp RADIOBUTTON GROUP g1,
  p_over RADIOBUTTON GROUP g1.

SELECTION-SCREEN END OF BLOCK b1.

*---------------------------------------------------------------------*
* Initialization
*---------------------------------------------------------------------*

INITIALIZATION.

  TEXT-001 = 'Assignment Filter'.

*---------------------------------------------------------------------*
* Start of Selection
*---------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM process_data.
  PERFORM display_report.

*---------------------------------------------------------------------*
* Get Assignment Data
*---------------------------------------------------------------------*

FORM get_data.

  CLEAR gt_assignment.

*---------------------------------------------------------------------*
* Sample assignment data
* Replace this section with SELECT from ZSTUDENT_TRACKER
*---------------------------------------------------------------------*

  gs_assignment-id         = '000001'.
  gs_assignment-subject    = 'DBMS'.
  gs_assignment-assignment = 'DBMS ASSIGNMENT'.
  gs_assignment-deadline   = '20260822'.
  gs_assignment-status     = 'COMPLETED'.
  gs_assignment-studyhours = '4'.
  APPEND gs_assignment TO gt_assignment.
  CLEAR gs_assignment.

  gs_assignment-id         = '000002'.
  gs_assignment-subject    = 'JAVA'.
  gs_assignment-assignment = 'JAVA ASSIGNMENT'.
  gs_assignment-deadline   = '20260822'.
  gs_assignment-status     = 'COMPLETED'.
  gs_assignment-studyhours = '3'.
  APPEND gs_assignment TO gt_assignment.
  CLEAR gs_assignment.

  gs_assignment-id         = '000003'.
  gs_assignment-subject    = 'OS'.
  gs_assignment-assignment = 'OS ASSIGNMENT'.
  gs_assignment-deadline   = '20260823'.
  gs_assignment-status     = 'DUE TODAY'.
  gs_assignment-studyhours = '2'.
  APPEND gs_assignment TO gt_assignment.
  CLEAR gs_assignment.

ENDFORM.

*---------------------------------------------------------------------*
* Process Data
*---------------------------------------------------------------------*

FORM process_data.

  CLEAR:
    gv_total,
    gv_completed,
    gv_pending,
    gv_overdue,
    gv_percent,
    gv_hours.

  CLEAR gt_display.

  LOOP AT gt_assignment INTO gs_assignment.

    gv_total = gv_total + 1.

    gv_hours = gv_hours + gs_assignment-studyhours.

    IF gs_assignment-status = 'COMPLETED'.

      gv_completed = gv_completed + 1.

    ELSEIF gs_assignment-status = 'OVERDUE'.

      gv_overdue = gv_overdue + 1.

    ELSE.

      gv_pending = gv_pending + 1.

    ENDIF.

*-------------------------------------------------------------------*
* Apply selection filter
*-------------------------------------------------------------------*

    IF p_all = 'X'.

      APPEND gs_assignment TO gt_display.

    ELSEIF p_pend = 'X'.

      IF gs_assignment-status <> 'COMPLETED'
         AND gs_assignment-status <> 'OVERDUE'.

        APPEND gs_assignment TO gt_display.

      ENDIF.

    ELSEIF p_comp = 'X'.

      IF gs_assignment-status = 'COMPLETED'.

        APPEND gs_assignment TO gt_display.

      ENDIF.

    ELSEIF p_over = 'X'.

      IF gs_assignment-status = 'OVERDUE'.

        APPEND gs_assignment TO gt_display.

      ENDIF.

    ENDIF.

  ENDLOOP.

*---------------------------------------------------------------------*
* Calculate completion percentage
*---------------------------------------------------------------------*

  IF gv_total > 0.

    gv_percent = ( gv_completed * 100 ) / gv_total.

  ENDIF.

ENDFORM.

*---------------------------------------------------------------------*
* Display Report
*---------------------------------------------------------------------*

FORM display_report.

  WRITE: / '============================================================'.
  WRITE: / '             STUDENT STUDY & ASSIGNMENT TRACKER'.
  WRITE: / '============================================================'.

  SKIP 1.

  WRITE: / 'Total Assignments : ', gv_total.
  WRITE: / 'Completed         : ', gv_completed.
  WRITE: / 'Pending           : ', gv_pending.
  WRITE: / 'Completion        : ', gv_percent, ' %'.
  WRITE: / 'Total Study Hours : ', gv_hours.

  SKIP 2.

*---------------------------------------------------------------------*
* Display selected filter
*---------------------------------------------------------------------*

  IF p_all = 'X'.

    WRITE: / 'Showing : ALL ASSIGNMENTS'.

  ELSEIF p_pend = 'X'.

    WRITE: / 'Showing : PENDING ASSIGNMENTS'.

  ELSEIF p_comp = 'X'.

    WRITE: / 'Showing : COMPLETED ASSIGNMENTS'.

  ELSEIF p_over = 'X'.

    WRITE: / 'Showing : OVERDUE ASSIGNMENTS'.

  ENDIF.

  SKIP 2.

*---------------------------------------------------------------------*
* Column headings
*---------------------------------------------------------------------*

  WRITE:
    / 'ID',
      12 'SUBJECT',
      25 'ASSIGNMENT',
      50 'DEADLINE',
      65 'STATUS'.

  WRITE: / '--------------------------------------------------------------------------'.

*---------------------------------------------------------------------*
* Display assignment records
*---------------------------------------------------------------------*

  LOOP AT gt_display INTO gs_display.

    WRITE:
      / gs_display-id,
        12 gs_display-subject,
        25 gs_display-assignment,
        50 gs_display-deadline DD/MM/YYYY,
        65 gs_display-status.

  ENDLOOP.

  SKIP 2.

  WRITE: / 'Total Study Hours : ', gv_hours.

  WRITE: / '============================================================'.

ENDFORM.
