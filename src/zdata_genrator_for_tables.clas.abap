CLASS zdata_genrator_for_tables DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.



CLASS ZDATA_GENRATOR_FOR_TABLES IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Delete existing data
    DELETE FROM zbh_boosupl_m.
    DELETE FROM zbh_booking_m.
    DELETE FROM zbh_travel_m.

    COMMIT WORK.

    "Travel
    INSERT zbh_travel_m FROM (
      SELECT *
        FROM /dmo/travel_m
    ).

    COMMIT WORK.

    "Booking
    INSERT zbh_booking_m FROM (
      SELECT
        travel_id,
        booking_id,
        booking_date,
        customer_id,
        carrier_id,
        connection_id,
        flight_date,
        flight_price,
        currency_code,
        booking_status,
        last_changed_at
      FROM /dmo/booking_m
    ).

    COMMIT WORK.

    "Booking Supplement
    INSERT zbh_boosupl_m FROM (
      SELECT
        travel_id,
        booking_id,
        booking_supplement_id,
        supplement_id,
        price,
        currency_code,
        last_changed_at
      FROM /dmo/booksuppl_m
    ).


    out->write( 'Travel, Booking and Booking Supplement demo data inserted successfully.' ).

  ENDMETHOD.
ENDCLASS.
