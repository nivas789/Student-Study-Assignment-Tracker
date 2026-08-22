METHOD studentassignmen_get_entity.

  DATA: lv_assignment_id TYPE zstudent_tracker-assignment_id.

  READ TABLE it_key_tab INTO DATA(ls_key)
       WITH KEY name = 'AssignmentId'.

  IF sy-subrc = 0.
    lv_assignment_id = ls_key-value.
  ENDIF.

  SELECT SINGLE *
    FROM zstudent_tracker
    INTO CORRESPONDING FIELDS OF @er_entity
    WHERE assignment_id = @lv_assignment_id.

ENDMETHOD.
