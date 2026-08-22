METHOD studentassignmen_create_entity.

  DATA: ls_student_assignment
          TYPE zcl_zstudent_tracker_mpc=>ts_studentassignment.

  "Read JSON data sent by the OData client
  io_data_provider->read_entry_data(
    IMPORTING
      es_data = ls_student_assignment
  ).

  "Insert the new record into the database table
  INSERT zstudent_tracker
    FROM CORRESPONDING FIELDS OF ls_student_assignment.

  IF sy-subrc <> 0.

    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        message = 'Unable to create student assignment'.

  ENDIF.

  "Return the newly created record
  MOVE-CORRESPONDING ls_student_assignment TO er_entity.

ENDMETHOD.
