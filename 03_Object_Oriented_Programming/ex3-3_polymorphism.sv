//******************************************************************************************
// Design:      Polymorphism Example
// 
// Description: 
//******************************************************************************************


module top;
    
    typedef enum {
        BLACK,
        RED,
        WHITE,
        SILVER
    } color_t;

    virtual class sports_car;
        rand color_t color;

        virtual function void print();
            $display("A %s sports car", color.name());
        endfunction
    endclass 

    class ferrari extends sports_car;      // child class 1

        virtual function void print();
            $display("A %s ferrari", color.name());
        endfunction
    endclass

    
    class porsche extends sports_car;     // child class 2

        virtual function void print();
            $display("A %s porsche", color.name());
        endfunction
    endclass


    sports_car cars[]; //allocate dynamic array
  
        ferrari    f1, f2;
        porsche    p1, p2;
            

     
    initial begin

        //create and randomize specific car models
      cars = new[4];

        f1 = new();
        f2 = new();
        void'(f1.randomize());
        void'(f2.randomize());
      
        p1 = new();
        p2 = new();
        void'(p1.randomize());
        void'(p2.randomize());

        //upcast into base class array
        $cast(cars[0], f1);
        $cast(cars[1], p1);
        $cast(cars[2], f2);
        $cast(cars[3], p2);

      print_all(cars);

    end
  task print_all(sports_car cars[]);
    for (int i = 0; i < cars.size(); i++)
      cars[i].print();
  endtask

    
endmodule


/***output***/

// # A SILVER ferrari
// # A RED porsche
// # A SILVER ferrari
// # A RED porsche