//******************************************************************************************
// Design:      Static methods and attributes Example
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

    virtual class car;
        static int counter = 0;      //shared by all instances
        int car_id;

        static local function void increment_counter();
            counter++;
            $display("creating item %0d ...", counter);
        endfunction

        function new();
            increment_counter();
            car_id = counter;
        endfunction
    endclass 

    virtual class sports_car extends car;;
        rand color_t color;

        virtual function void print();
            $display("Car #%0d: A %s sports car", car_id, color.name());
        endfunction
    endclass 


    class ferrari extends sports_car;      // child class 1

        virtual function void print();
            $display("Car #%0d: A %s ferrari", car_id, color.name());
        endfunction
    endclass

    
    class porsche extends sports_car;     // child class 2

        virtual function void print();
            $display("Car #%0d: A %s porsche", car_id, color.name());
        endfunction
    endclass


    task print_all(sports_car cars[]);
        for (int i = 0; i < cars.size(); i++)
          cars[i].print();
      endtask


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
 

    
endmodule


/***output***/

// # creating item 1 ...
// # creating item 2 ...
// # creating item 3 ...
// # creating item 4 ...
// # Car #1: A SILVER ferrari
// # Car #3: A RED porsche
// # Car #2: A SILVER ferrari
// # Car #4: A RED porsche


/*
p1 = new();          // Creates an object
 ↳ Inherits car::new()
     ↳ calls increment_counter()
         ↳ counter++
         ↳ display "creating item X ..."

*/