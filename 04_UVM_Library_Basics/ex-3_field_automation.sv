//******************************************************************************************
// Design:    
// 
// Description:  uvm_object fields automation 
//******************************************************************************************


import uvm_pkg::*;
`include "uvm_macros.svh"

// class packet_header - length, addr

class packet_header extends uvm_object;
  rand bit [5:0] length;
    rand bit [1:0] addr;


    `uvm_object_utils_begin(packet_header)
  `uvm_field_int(length, UVM_DEFAULT)
  `uvm_field_int(addr, UVM_DEFAULT)
    `uvm_object_utils_end

    function new (string name="packet_header");
        super.new(name);
    endfunction
endclass


typedef enum bit {
    BAD_PARITY,
    GOOD_PARITY
}parity_e;

//class simple_packet

class simple_packet extends uvm_object;
    //physical data
    rand packet_header header; // packet header class
    rand bit [7:0] payload []; // dynamic array
    bit      [7:0] parity;     // calculated in post_randomize()

    //control knobs
    rand parity_e parity_type;
    rand int      packet_delay;

    //default constraints
    constraint c_default_length {header.length > 0; header.length < 64;}
    constraint c_payload_size   {header.length == payload.size();}
    constraint c_packet_delay   {packet_delay inside {[0:10]};}


    // UVM macros for built-in automation

    `uvm_object_utils_begin(simple_packet)
        `uvm_field_object(header, UVM_DEFAULT)
        `uvm_field_array_int(payload, UVM_DEFAULT)
        `uvm_field_int(parity, UVM_DEFAULT)
        `uvm_field_enum(parity_e, parity_type, UVM_DEFAULT)
        `uvm_field_int(packet_delay, UVM_DEFAULT | UVM_DEC | UVM_NOCOMPARE)
    `uvm_object_utils_end

    function new (string name = "simple_packet");
        super.new(name);
        header = packet_header::type_id::create("header");//allocation
    endfunction


    // this method calculates the parity over the header and payload
    function bit [7:0] calc_parity();
        calc_parity = {header.length, header.addr};
        for (int i = 0; i < header.length; i++)
            calc_parity = calc_parity ^ payload[i];
    endfunction


    //post_randomize() - calculates parity
    function void post_randomize();
        if (parity_type == GOOD_PARITY)
           parity = calc_parity();
        else do
           parity = $urandom;
        while(parity == calc_parity()); 
    endfunction

endclass


module test;
    simple_packet packet;

    initial begin
        packet = new("packet");

        repeat(3) begin
            void'(packet.randomize());
            packet.print();
        end
    end
endmodule

/*output*/


/*
# -----------------------------------------------
# Name            Type           Size  Value     
# -----------------------------------------------
# packet          simple_packet  -     @355      
#   header        packet_header  -     @356      
#     length      integral       6     'he       
#     addr        integral       2     'h0       
#   payload       da(integral)   14    -         
#     [0]         integral       8     'hcd      
#     [1]         integral       8     'h9d      
#     [2]         integral       8     'hee      
#     [3]         integral       8     'hb9      
#     [4]         integral       8     'hbc      
#     ...         ...            ...   ...       
#     [9]         integral       8     'h25      
#     [10]        integral       8     'h1f      
#     [11]        integral       8     'h84      
#     [12]        integral       8     'hff      
#     [13]        integral       8     'h6       
#   parity        integral       8     'ha       
#   parity_type   parity_e       1     BAD_PARITY
#   packet_delay  integral       32    'd4       
# -----------------------------------------------
*/