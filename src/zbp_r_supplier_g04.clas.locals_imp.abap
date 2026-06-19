CLASS lhc_zr_supplier_g04 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrSupplierG04
        RESULT result,

      validateSupplier FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrSupplierG04~validateSupplier.
ENDCLASS.

CLASS lhc_zr_supplier_g04 IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validateSupplier.
    " 1. Read the fields we need to check
    READ ENTITIES OF zr_supplier_g04 IN LOCAL MODE
      ENTITY ZrSupplierG04
        FIELDS ( SupplierID Name ContactEmail ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_supplier).

    " 2. Loop through the records to validate
    LOOP AT lt_supplier INTO DATA(ls_supplier).

      APPEND VALUE #( %tky        = ls_supplier-%tky
                      %state_area = 'VALIDATE_SUPPLIER' ) TO reported-ZrSupplierG04.

      " Check 1: Supplier ID must not be empty
      IF ls_supplier-SupplierID IS INITIAL.
        APPEND VALUE #( %tky = ls_supplier-%tky ) TO failed-ZrSupplierG04.

        APPEND VALUE #( %tky                = ls_supplier-%tky
                        %state_area         = 'VALIDATE_SUPPLIER'
                        %msg                = new_message_with_text(
                                                severity = if_abap_behv_message=>severity-error
                                                text     = 'Supplier ID cannot be empty!' )
                        %element-SupplierID = if_abap_behv=>mk-on ) TO reported-ZrSupplierG04.
      ENDIF.

      " Check 2: Name must not be empty
      IF ls_supplier-Name IS INITIAL.
        APPEND VALUE #( %tky = ls_supplier-%tky ) TO failed-ZrSupplierG04.

        APPEND VALUE #( %tky          = ls_supplier-%tky
                        %state_area   = 'VALIDATE_SUPPLIER'
                        %msg          = new_message_with_text(
                                          severity = if_abap_behv_message=>severity-error
                                          text     = 'Supplier name cannot be empty!' )
                        %element-Name = if_abap_behv=>mk-on ) TO reported-ZrSupplierG04.
      ENDIF.

      " Check 3: Email must not be empty and must look like a valid email
      IF ls_supplier-ContactEmail IS INITIAL.
        APPEND VALUE #( %tky = ls_supplier-%tky ) TO failed-ZrSupplierG04.

        APPEND VALUE #( %tky                  = ls_supplier-%tky
                        %state_area           = 'VALIDATE_SUPPLIER'
                        %msg                  = new_message_with_text(
                                                  severity = if_abap_behv_message=>severity-error
                                                  text     = 'Contact email cannot be empty!' )
                        %element-ContactEmail = if_abap_behv=>mk-on ) TO reported-ZrSupplierG04.

      ELSEIF ls_supplier-ContactEmail NP '*@*.*'.
        APPEND VALUE #( %tky = ls_supplier-%tky ) TO failed-ZrSupplierG04.

        APPEND VALUE #( %tky                  = ls_supplier-%tky
                        %state_area           = 'VALIDATE_SUPPLIER'
                        %msg                  = new_message_with_text(
                                                  severity = if_abap_behv_message=>severity-error
                                                  text     = 'Contact email format is invalid!' )
                        %element-ContactEmail = if_abap_behv=>mk-on ) TO reported-ZrSupplierG04.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

