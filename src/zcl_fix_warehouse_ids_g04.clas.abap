CLASS zcl_fix_warehouse_ids_g04 DEFINITION
  PUBLIC FINAL CREATE PUBLIC
  INHERITING FROM cl_demo_classrun.

  PUBLIC SECTION.
    METHODS main REDEFINITION.
ENDCLASS.

CLASS zcl_fix_warehouse_ids_g04 IMPLEMENTATION.
  METHOD main.

    " 1. Fetch all warehouses ordered by creation time
    SELECT warehouse_uuid, warehouse_id, local_created_at
      FROM zwarehouse_g04
      ORDER BY local_created_at ASCENDING
      INTO TABLE @DATA(lt_warehouses).

    " 2. Assign clean WAR0001, WAR0002... to every record
    DATA(lv_counter) = 1.
    LOOP AT lt_warehouses INTO DATA(ls_wh).

      " Pad the counter to 4 digits manually
      DATA(lv_padded) = CONV string( lv_counter ).
      WHILE strlen( lv_padded ) < 4.
        lv_padded = |0{ lv_padded }|.
      ENDWHILE.

      DATA(lv_new_id) = |WAR{ lv_padded }|.

      UPDATE zwarehouse_g04
        SET warehouse_id = @lv_new_id
        WHERE warehouse_uuid = @ls_wh-warehouse_uuid.

      out->write( |{ ls_wh-warehouse_uuid } → { lv_new_id }| ).
      lv_counter += 1.
    ENDLOOP.

    out->write( 'Done! All Warehouse IDs realigned.' ).
  ENDMETHOD.
ENDCLASS.
