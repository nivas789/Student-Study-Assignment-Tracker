METHOD studentassignmen_get_entityset.

  SELECT *
    FROM zstudent_tracker
    INTO CORRESPONDING FIELDS OF TABLE @et_entityset.

ENDMETHOD.
