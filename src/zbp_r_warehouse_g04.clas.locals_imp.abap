CLASS LHC_ZR_WAREHOUSE_G04 DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrWarehouseG04
        RESULT result,

      validateCapacity FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrWarehouseG04~validateCapacity.
ENDCLASS.

CLASS LHC_ZR_WAREHOUSE_G04 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validateCapacity.
    READ ENTITIES OF zr_warehouse_g04 IN LOCAL MODE
      ENTITY ZrWarehouseG04
        FIELDS ( Capacity ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_warehouse).

    LOOP AT lt_warehouse INTO DATA(ls_warehouse).

      APPEND VALUE #( %tky        = ls_warehouse-%tky
                      %state_area = 'VALIDATE_CAPACITY' ) TO reported-ZrWarehouseG04.

      IF ls_warehouse-Capacity <= 0.
        APPEND VALUE #( %tky = ls_warehouse-%tky ) TO failed-ZrWarehouseG04.

        APPEND VALUE #( %tky              = ls_warehouse-%tky
                        %state_area       = 'VALIDATE_CAPACITY'
                        %msg              = new_message_with_text(
                                              severity = if_abap_behv_message=>severity-error
                                              text     = 'Capacity must be greater than zero!' )
                        %element-Capacity = if_abap_behv=>mk-on ) TO reported-ZrWarehouseG04.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
