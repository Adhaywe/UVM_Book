//******************************************************************************************
// Design:      downcast Example
// 
// Description: You “cast down” from the base class sports_cars to the derived class lada_flying.
//******************************************************************************************


module top;
    
    typedef enum {
        BLACK,
        RED,
        WHITE,
        SILVER
    } color_t;

    virtual class sports_car;
        int id = 0;
        rand color_t color;

        virtual function void print();
            $display("Car: %0d - A %s sports car", id, color.name());
        endfunction
    endclass
    
    class lada_flying extends sports_car;
        //fly function unique to this sub class
        virtual function void fly();
            $display("Car:%0d %m I'm flying", id);
        endfunction

        virtual function void print();
            $display("Car: %0d - A %s lada_flying", id, color.name());
        endfunction
    endclass

    class ferrari extends sports_car;      // child class 1

        virtual function void print();
            $display("Car:%0d - A %s ferrari", id,  color.name());
        endfunction
    endclass

    
    task fly_if_you_can(sports_car cars[]);
        lada_flying this_car;

        for (int i = 0; i < cars.size(); i++) begin
            if ($cast(this_car, cars[i])) // base class does not know what fly is so we try to downcast $cast(dest, src) return true or false
               this_car.fly();
        end
    endtask

    task print_all(sports_car cars[]);
        for (int i = 0; i < cars.size(); i++)
          cars[i].print();
      endtask
    


    sports_car cars[]; //allocate dynamic array
  
        ferrari      f1, f2;
        lada_flying  p1, p2;
            

     
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

        foreach(cars[i]) cars[i].id = i;

        print_all(cars);
        fly_if_you_can(cars);

    end
  
    
endmodule


/***output***/

//# Car:0 - A SILVER ferrari
//# Car:1 - A RED lada_flying
//# Car:2 - A SILVER ferrari
//# Car:3 - A RED lada_flying
//# Car:1 top.lada_flying.fly I'm flying
//# Car:3 top.lada_flying.fly I'm flying