CLASS lhc_zr_inventory_g04 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrInventoryG04
        RESULT result,
      validateQuantity FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrInventoryG04~validateQuantity,

      validateRestockDate FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrInventoryG04~validateRestockDate,

        " Determination method declaration
      setInitialDate FOR DETERMINE ON MODIFY
            IMPORTING keys FOR ZrInventoryG04~setInitialDate.
ENDCLASS.

CLASS lhc_zr_inventory_g04 IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

 METHOD validateQuantity.
    " 1. Read the Quantity field from the current inventory records
    READ ENTITIES OF zr_inventory_g04 IN LOCAL MODE
      ENTITY ZrInventoryG04
        FIELDS ( Quantity ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_inventory).

    " 2. Loop through the records to check the value
    LOOP AT lt_inventory INTO DATA(ls_inventory).

      APPEND VALUE #( %tky        = ls_inventory-%tky
                      %state_area = 'VALIDATE_QUANTITY' ) TO reported-ZrInventoryG04.

      IF ls_inventory-Quantity <= 0.
         " 3. Mark the record as failed to prevent saving
        APPEND VALUE #( %tky = ls_inventory-%tky ) TO failed-ZrInventoryG04.

        " 4. Display a meaningful error message to the user
        APPEND VALUE #( %tky              = ls_inventory-%tky
                        %state_area       = 'VALIDATE_QUANTITY'
                        %msg              = new_message_with_text(
                                              severity = if_abap_behv_message=>severity-error
                                              text     = 'Quantity must be greater than zero!' )
                        %element-Quantity = if_abap_behv=>mk-on ) TO reported-ZrInventoryG04.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD validateRestockDate.
    " 1. Read the LastRestockDate field from the current records
    READ ENTITIES OF zr_inventory_g04 IN LOCAL MODE
      ENTITY ZrInventoryG04
        FIELDS ( LastRestockDate ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_inventory).

    " 2. Get the current system date securely
    DATA(lv_current_date) = cl_abap_context_info=>get_system_date( ).

    " 3. Loop through the records to check the date
    LOOP AT lt_inventory INTO DATA(ls_inventory).


      APPEND VALUE #( %tky        = ls_inventory-%tky
                      %state_area = 'VALIDATE_DATE' ) TO reported-ZrInventoryG04.

      " Check if the user entered a date that is strictly in the future
      IF ls_inventory-LastRestockDate > lv_current_date.

        " 4. Mark the record as failed to prevent saving
        APPEND VALUE #( %tky = ls_inventory-%tky ) TO failed-ZrInventoryG04.

        " 5. Display a meaningful error message pointing to the specific field
        APPEND VALUE #( %tky                     = ls_inventory-%tky
                        %state_area              = 'VALIDATE_DATE'
                        %msg                     = new_message_with_text(
                                                     severity = if_abap_behv_message=>severity-error
                                                     text     = 'Restock date cannot be in the future!' )
                        %element-LastRestockDate = if_abap_behv=>mk-on ) TO reported-ZrInventoryG04.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD setInitialDate.
    " 1. Read the newly created records
    READ ENTITIES OF zr_inventory_g04 IN LOCAL MODE
      ENTITY ZrInventoryG04
        FIELDS ( LastRestockDate ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_inventory).

    " 2. Update the records with the current system date
    MODIFY ENTITIES OF zr_inventory_g04 IN LOCAL MODE
      ENTITY ZrInventoryG04
        UPDATE FIELDS ( LastRestockDate )
        WITH VALUE #( FOR ls_inventory IN lt_inventory
                      ( %tky            = ls_inventory-%tky
                        LastRestockDate = cl_abap_context_info=>get_system_date( ) ) )
      REPORTED DATA(lt_reported).

    " 3. Pass any reported messages back to the framework
    reported = CORRESPONDING #( DEEP lt_reported ).
  ENDMETHOD.

ENDCLASS.

