CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS checkDates FOR VALIDATE ON SAVE
      keys FOR Travel~checkDates.

    METHODS calculateTotalPrice FOR DETERMINE ON MODIFY
      keys FOR Travel~calculateTotalPrice.

*    METHODS acceptButton FOR MODIFY
*      keys FOR ACTION Travel~acceptButton RESULT result.



ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD checkDates.

  READ ENTITIES OF zcds_travel_m IN LOCAL MODE
  ENTITY Travel
  FIELDS ( BeginDate EndDate )
  WITH CORRESPONDING #( keys )
  RESULT DATA(lt_travel).

  LOOP AT lt_travel INTO DATA(WA_TRAVEL).

    IF wa_travel-BeginDate > wa_travel-EndDate.

        APPEND VALUE #( %tky = wa_travel-%tky )
            to failed-travel.

        APPEND VALUE #(
            %tky = wa_travel-%tky
            %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Begin Date cannot be later than End Date.'
             )
        ) to reported-travel.

    ENDIF.
  ENDLOOP.

  ENDMETHOD.

  METHOD calculateTotalPrice.


    READ ENTITIES OF zcds_travel_m IN LOCAL MODE
    ENTITY Travel
    FIELDS ( TotalPrice )
    WITH CORRESPONDING #( keys )
    RESULT DATA(LT_TRAVEL).

    MODIFY ENTITIES OF ZCDS_TRAVEL_M IN LOCAL MODE
    ENTITY Travel
    UPDATE FIELDS ( TotalPrice )
    WITH VALUE #(
        FOR LS_TRAVEL IN lt_travel
        (
            %tky = ls_travel-%tky
            TotalPrice = ls_travel-BookinfFee + 1000
         )

    ).
  ENDMETHOD.

*  METHOD get_instance_features.
*
*  READ ENTITIES OF zcds_travel_m IN LOCAL MODE
*    ENTITY Travel
*    FIELDS ( OverallStatus )
*    WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_travel).
*
*  result = VALUE #(
*    FOR ls_travel IN lt_travel
*    (
*      %tky = ls_travel-%tky
*
*      %action-acceptButton =
*        COND #(
*          WHEN ls_travel-OverallStatus = 'O'
*          THEN if_abap_behv=>fc-o-enabled
*          ELSE if_abap_behv=>fc-o-disabled
*        )
*    )
*  ).
*
*ENDMETHOD.

*  METHOD acceptButton.
*
*  MODIFY ENTITIES OF zcds_travel_m IN LOCAL MODE
*    ENTITY Travel
*    UPDATE FIELDS ( OverallStatus )
*    WITH VALUE #(
*      FOR ls_key IN keys
*      (
*        %tky = ls_key-%tky
*        OverallStatus = 'A'
*      )
*    )
*    FAILED DATA(lt_failed)
*    REPORTED DATA(lt_reported).
*
*  READ ENTITIES OF zcds_travel_m IN LOCAL MODE
*    ENTITY Travel
*    ALL FIELDS
*    WITH CORRESPONDING #( keys )
*
*    RESULT DATA(lt_travel).
*
*  result = VALUE #(
*    FOR ls_travel IN lt_travel
*    (
*      %tky = ls_travel-%tky
*      %param = ls_travel
*    )
*  ).
*
*ENDMETHOD.

ENDCLASS.
