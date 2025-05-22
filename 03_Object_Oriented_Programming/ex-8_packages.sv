//******************************************************************************************
// Design:     packages Example
// 
// Description: 
//******************************************************************************************



package ferrari_pkg;
    typedef enum {
        RED,
        BLACK,
        SILVER
    } color_t;

    class sports_car;
        rand color_t color;

        virtual function void print();
            $display("A %0d ferrari sports car", color.name());
        endfunction
    endclass
endpackage


package porsche_pkg;
    typedef enum {
        WHITE,
        BLUE,
        GRAY
    } color_t;

    class sports_car;
        rand color_t color;

        virtual function void print();
            $display("A %0d porsche sports car", color.name());
        endfunction
    endclass
endpackage


module top;
    ferrari_pkg::sports_car f1;
    porsche_pkg::sports_car p1;

    initial begin
        f1 = new();
        void'(f1.randomize());
        f1.print();

        p1 = new();
        void'(p1.randomize());
        p1.print();
    end
endmodule