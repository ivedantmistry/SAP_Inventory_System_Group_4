CLASS zcl_generate_data_g04 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
ENDCLASS.

CLASS zcl_generate_data_g04 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: it_category  TYPE TABLE OF zcategory_g04,
          it_supplier  TYPE TABLE OF zsupplier_g04,
          it_warehouse TYPE TABLE OF zwarehouse_g04,
          it_product   TYPE TABLE OF zproduct_g04,
          it_inventory TYPE TABLE OF zinventory_g04.

    " Clear old data
    DELETE FROM zcategory_g04.
    DELETE FROM zsupplier_g04.
    DELETE FROM zwarehouse_g04.
    DELETE FROM zproduct_g04.
    DELETE FROM zinventory_g04.

    GET TIME STAMP FIELD DATA(lv_ts).
    DATA(lv_user) = cl_abap_context_info=>get_user_technical_name( ).

    TRY.
        " 1. Insert Category
        it_category = VALUE #(
          ( category_uuid    = cl_system_uuid=>create_uuid_x16_static( )
            category_id      = 'CAT01'
            name             = 'Football Shirts'
            local_created_by = lv_user
            local_created_at = lv_ts )

          ( category_uuid    = cl_system_uuid=>create_uuid_x16_static( )
            category_id      = 'CAT02'
            name             = 'Football Boots'
            local_created_by = lv_user
            local_created_at = lv_ts )

          ( category_uuid    = cl_system_uuid=>create_uuid_x16_static( )
            category_id      = 'CAT03'
            name             = 'Goalkeeper Gear'
            local_created_by = lv_user
            local_created_at = lv_ts )
        ).
        INSERT zcategory_g04 FROM TABLE @it_category.

        " 2. Insert Supplier
        it_supplier = VALUE #(
          ( supplier_uuid    = cl_system_uuid=>create_uuid_x16_static( )
            supplier_id      = 'SUP01'
            name             = 'Adidas Germany'
            contact_email    = 'contact@adidas.de'
            local_created_by = lv_user
            local_created_at = lv_ts )

          ( supplier_uuid    = cl_system_uuid=>create_uuid_x16_static( )
            supplier_id      = 'SUP02'
            name             = 'Nike Europe'
            contact_email    = 'supply@nike.eu'
            local_created_by = lv_user
            local_created_at = lv_ts )

          ( supplier_uuid    = cl_system_uuid=>create_uuid_x16_static( )
            supplier_id      = 'SUP03'
            name             = 'Puma Global'
            contact_email    = 'info@puma.com'
            local_created_by = lv_user
            local_created_at = lv_ts )
        ).
        INSERT zsupplier_g04 FROM TABLE @it_supplier.

        " 3. Insert Warehouse
        it_warehouse = VALUE #(
          ( warehouse_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            warehouse_id     = 'WH-MUN'
            location         = 'Munich Central'
            capacity         = 5000
            local_created_by = lv_user
            local_created_at = lv_ts )

          ( warehouse_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            warehouse_id     = 'WH-BER'
            location         = 'Berlin Hub'
            capacity         = 3000
            local_created_by = lv_user
            local_created_at = lv_ts )

          ( warehouse_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            warehouse_id     = 'WH-HAM'
            location         = 'Hamburg Port'
            capacity         = 8000
            local_created_by = lv_user
            local_created_at = lv_ts )
        ).
        INSERT zwarehouse_g04 FROM TABLE @it_warehouse.

        " 4. Insert Product
        it_product = VALUE #(
          ( product_uuid     = cl_system_uuid=>create_uuid_x16_static( )
            product_id       = 'PRD001'
            name             = 'Bayern Munich Home'
            category_uuid    = it_category[ 1 ]-category_uuid
            supplier_uuid    = it_supplier[ 1 ]-supplier_uuid
            price            = '90.00'
            currency         = 'EUR'
            local_created_by = lv_user
            local_created_at = lv_ts )

          ( product_uuid     = cl_system_uuid=>create_uuid_x16_static( )
            product_id       = 'PRD002'
            name             = 'Mercurial Vapor 15'
            category_uuid    = it_category[ 2 ]-category_uuid
            supplier_uuid    = it_supplier[ 2 ]-supplier_uuid
            price            = '250.00'
            currency         = 'EUR'
            local_created_by = lv_user
            local_created_at = lv_ts )

          ( product_uuid     = cl_system_uuid=>create_uuid_x16_static( )
            product_id       = 'PRD003'
            name             = 'Puma Future Pro'
            category_uuid    = it_category[ 3 ]-category_uuid
            supplier_uuid    = it_supplier[ 3 ]-supplier_uuid
            price            = '130.00'
            currency         = 'EUR'
            local_created_by = lv_user
            local_created_at = lv_ts )

          ( product_uuid     = cl_system_uuid=>create_uuid_x16_static( )
            product_id       = 'PRD004'
            name             = 'Predator Gloves'
            category_uuid    = it_category[ 3 ]-category_uuid
            supplier_uuid    = it_supplier[ 1 ]-supplier_uuid
            price            = '85.00'
            currency         = 'EUR'
            local_created_by = lv_user
            local_created_at = lv_ts )
        ).
        INSERT zproduct_g04 FROM TABLE @it_product.

        " 5. Insert Inventory - extended with 20+ entries, 10+ with quantity <50
        it_inventory = VALUE #(
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 1 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 1 ]-warehouse_uuid
            quantity         = 150
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 2 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 2 ]-warehouse_uuid
            quantity         = 45 " 1 <50
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 3 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 3 ]-warehouse_uuid
            quantity         = 200
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 4 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 1 ]-warehouse_uuid
            quantity         = 30 " 2 <50
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )

          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 1 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 2 ]-warehouse_uuid
            quantity         = 12 " 3 <50
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 2 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 3 ]-warehouse_uuid
            quantity         = 7  " 4 <50
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 3 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 1 ]-warehouse_uuid
            quantity         = 25 " 5 <50
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 4 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 2 ]-warehouse_uuid
            quantity         = 5  " 6 <50
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 1 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 3 ]-warehouse_uuid
            quantity         = 300
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 2 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 1 ]-warehouse_uuid
            quantity         = 44 " 7 <50
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 3 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 2 ]-warehouse_uuid
            quantity         = 40 " 8 <50
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 4 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 3 ]-warehouse_uuid
            quantity         = 10 " 9 <50
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )

          " Add more with both high and <50 quantity
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 1 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 1 ]-warehouse_uuid
            quantity         = 49 " 10 <50
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 2 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 2 ]-warehouse_uuid
            quantity         = 400
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 3 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 3 ]-warehouse_uuid
            quantity         = 38 " 11 <50
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 4 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 1 ]-warehouse_uuid
            quantity         = 13 " 12 <50
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 1 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 2 ]-warehouse_uuid
            quantity         = 800
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 2 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 3 ]-warehouse_uuid
            quantity         = 20 " 13 <50
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 3 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 1 ]-warehouse_uuid
            quantity         = 100
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 4 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 2 ]-warehouse_uuid
            quantity         = 2  " 14 <50
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 1 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 3 ]-warehouse_uuid
            quantity         = 71
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
          ( inventory_uuid   = cl_system_uuid=>create_uuid_x16_static( )
            product_uuid     = it_product[ 2 ]-product_uuid
            warehouse_uuid   = it_warehouse[ 1 ]-warehouse_uuid
            quantity         = 21 " 15 <50
            unit_of_measure  = 'PC'
            last_restock_date = cl_abap_context_info=>get_system_date( )
            local_created_by = lv_user
            local_created_at = lv_ts )
        ).
        INSERT zinventory_g04 FROM TABLE @it_inventory.

        out->write( 'Database populated successfully with extensive test data.' ).

      CATCH cx_uuid_error.
        out->write( 'Error: Could not generate UUID' ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
