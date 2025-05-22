//******************************************************************************************
// Design:     packages nd namespace Example
// 
// Description: 
//******************************************************************************************



package ferrari_pkg;
    typedef enum {
        RED,
        BLACK,
        SILVER
    } color_t;

    virtual class sports_car;
        rand color_t color;

        virtual function void print();
            $display("A %0d ferrari sports car", color.name());
        endfunction
    endclass


    class f1 extends sports_car;
    endclass
endpackage


package porsche_pkg;
    typedef enum {
        WHITE,
        BLUE,
        GRAY
    } color_t;

    virtual class sports_car;
        rand color_t color;

        virtual function void print();
            $display("A %0d porsche sports car", color.name());
        endfunction
    endclass

    class p1 extends sports_car;
    endclass
endpackage


module top;
    import ferrari_pkg::*;
    import porsche_pkg::*;

    f1 my_f1;
    p1 my_p1;

    initial begin
        my_f1 = new();
        void'(my_f1.randomize());
        my_f1.print();

        my_p1 = new();
        void'(my_p1.randomize());
        my_p1.print();
    end
endmodule


/***output***/


//# A BLACK ferrari sports car
//# A WHITE porsche sports car