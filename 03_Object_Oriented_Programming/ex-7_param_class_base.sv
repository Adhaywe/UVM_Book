//******************************************************************************************
// Design:     parameterized class Example
// 
// Description: 
//******************************************************************************************


module top;

    class stack_base;

        static int stacks;
        local int id;

        function new();
            stacks++;
            id = stacks;
        endfunction

        function int get_id();
            return id;
        endfunction

    endclass

    class stack #(type T = int) extends stack_base;

        local T items[$];

        task push(T a); 
            items.push_back(a);
            $display("Pushed: %p | stack:%p", a, items);
        endtask

        task pop(ref T a);      //pass the value of a by reference
                if (items.size() > 0) begin
                    a = items.pop_back();
                    $display("Popped: %p | stack:%p", a, items);
                end
                else begin
                    $display("Pop failed! Stack is empty");
                end
        endtask

    endclass
    
    //declare stack instances
    stack#(int) int_stack = new();
    stack#(bit[9:0]) bit_stack = new();
    stack#(real) real_stack = new();

    int i;
    bit[9:0] b;
    real r;

    initial begin
        $display("\n----INT stack----");
        int_stack.push(40);
        int_stack.push(50);
        int_stack.pop(i);
        int_stack.pop(i);
        int_stack.pop(i);
        int_stack.get_id();

        $display("\n----BIT stack----");
        bit_stack.push(10'b0101010101);
        bit_stack.push(10'b0000011111);
        bit_stack.pop(b);
        bit_stack.pop(b);
        bit_stack.pop(b);
        bit_stack.get_id();

        $display("\n----REAL stack----");
        real_stack.push(3.14);
        real_stack.push(1.11);
        real_stack.pop(r);
        real_stack.pop(r);
        real_stack.pop(r);
        real_stack.get_id();

   end
   
endmodule



/***output***/


//# ----INT stack----
//# Pushed: 40 | stack:'{40}
//# Pushed: 50 | stack:'{40, 50}
//# Popped: 50 | stack:'{40}
//# Popped: 40 | stack:'{}
//# Pop failed! Stack is empty
//# ID: 1
//# 
//# ----BIT stack----
//# Pushed: 341 | stack:'{341}
//# Pushed: 31 | stack:'{341, 31}
//# Popped: 31 | stack:'{341}
//# Popped: 341 | stack:'{}
//# Pop failed! Stack is empty
//# ID: 2
//# 
//# ----REAL stack----
//# Pushed: 3.14 | stack:'{3.14}
//# Pushed: 1.11 | stack:'{3.14, 1.11}
//# Popped: 1.11 | stack:'{3.14}
//# Popped: 3.14 | stack:'{}
//# Pop failed! Stack is empty
//# ID: 3