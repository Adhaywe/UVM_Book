//******************************************************************************************
// Design:     hello world
// 
// Description: 
//******************************************************************************************


module hello_world;

    //import UVM library and include the UVM macros
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    initial begin
        `uvm_info("info1", "Hello World!", UVM_LOW); //verbosity level low
    end
endmodule

/***output***/

// # UVM_INFO testbench.sv(11) @ 0: reporter [info1] Hello World!