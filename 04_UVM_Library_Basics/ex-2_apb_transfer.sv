//******************************************************************************************
// Design:     non uvm class definition
// 
// Description: 
//******************************************************************************************


import uvm_pkg::*;
`include "uvm_macros.svh"

typedef enum {
    APB_READ,
    APB_WRITE
} app_direction_t;

class apb_transfer extends uvm_object;
    rand bit [31:0]      addr;
    rand bit [31:0]      data;
    rand app_direction_t direction;

    //control field - does not translate into signal data
    rand bit unsigned transmit_delay;

    //uvm automation macros for data items
    `uvm_object_utils_begin(apb_transfer)
        `uvm_field_int(addr, UVM_DEFAULT)
        `uvm_field_int(data, UVM_DEFAULT)
        `uvm_field_enum(app_direction_t, direction, UVM_DEFAULT)
        `uvm_field_int(transmit_delay, UVM_DEFAULT | UVM_NOCOMPARE)
    `uvm_object_utils_end

    //constructor - required UVM syntax
    function new(string name="apb_transfer");
        super.new(name);
    endfunction

endclass


module test;
    apb_transfer transfer;

    initial begin
      transfer = new();
      repeat(3) begin
        void'(transfer.randomize());
        transfer.print();
      end
    end
endmodule

/***output***/

/*# ---------------------------------------------------
# Name              Type             Size  Value     
# ---------------------------------------------------
# apb_transfer      apb_transfer     -     @355      
#   addr            integral         32    'hdef25da4
#   data            integral         32    'hd60a92de
#   direction       app_direction_t  32    APB_WRITE 
#   transmit_delay  integral         1     'h0       
# ---------------------------------------------------
# ---------------------------------------------------
# Name              Type             Size  Value     
# ---------------------------------------------------
# apb_transfer      apb_transfer     -     @355      
#   addr            integral         32    'h8d41f057
#   data            integral         32    'h978c5c56
#   direction       app_direction_t  32    APB_READ  
#   transmit_delay  integral         1     'h0       
# ---------------------------------------------------
# ---------------------------------------------------
# Name              Type             Size  Value     
# ---------------------------------------------------
# apb_transfer      apb_transfer     -     @355      
#   addr            integral         32    'h568363c4
#   data            integral         32    'h5a7c355f
#   direction       app_direction_t  32    APB_WRITE 
#   transmit_delay  integral         1     'h0       
# ---------------------------------------------------*/