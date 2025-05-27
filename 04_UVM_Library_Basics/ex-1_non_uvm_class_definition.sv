//******************************************************************************************
// Design:     non uvm class definition
// 
// Description: 
//******************************************************************************************

typedef enum {
    APB_WRITE,
    APB_READ
} apb_direction;

class apb_transfer; 
    rand bit [31:0]    addr;
    rand bit [31:0]    data;
    rand apb_direction direction;

    function void print();
        $display("%s transfer: addr=%h data=%h", direction, addr, data);
    endfunction
endclass 

module test;
  apb_transfer transfer;
  
  initial begin
    transfer = new();
    void'(transfer.randomize());
    transfer.print();
  end
endmodule

    /***output***/

    //  # APB_READ transfer: addr=def25da4 data=d60a92de