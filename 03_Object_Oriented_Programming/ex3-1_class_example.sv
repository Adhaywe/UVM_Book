//******************************************************************************************
// Design:      SystemVerilog Class Example
// 
// Description: 
//******************************************************************************************

// Code your testbench here
// or browse Examples


class car; //class definition

    typedef enum {
        AUTOMATIC,
        MANUAL
    } transmission_t;

    int            m_num_doors;
    bit            m_is_locked[];   //declare a dynamic array
    transmission_t m_trans;


 //public interfaces 
  task drive_forward(input int door);
    if (m_is_locked[door] == 0)
        $display("Car with transmission: %d is moving forward", m_trans.name());
      else
        $display("Open your car first!");
    endtask

    task unlock_door(input int door);
        m_is_locked[door] = 0;
      $display("door opened!");
    endtask

    task lock_door(input int door);
        m_is_locked[door] = 1;
      $display("door closed!");
    endtask

    task open_door(input int door);
        if (m_is_locked[door] == 1) begin
            $display("Unlock door[%d] first", door);
        end else begin
            $display("door[%d] is unlocked", door);    
            end
    endtask

    function new(input int num_doors = 2, input transmission_t trans=AUTOMATIC);
        m_trans = trans;
        m_num_doors = num_doors;
        m_is_locked = new[num_doors];   //allocate memory for num_doors elements
      
      //new[4] = '{1, 1, 1, 1}

        //foreach(m_is_locked[i])
          //      m_is_locked[i] = 1;
        for (int i = 0; i < num_doors; i++) begin
            m_is_locked[i] = 1;
        end
    endfunction



endclass


module top;
    car my_car;

    initial begin
      my_car = new(4);       //object of instance
      my_car.lock_door(1);
      my_car.unlock_door(1);
      my_car.open_door(1);
      my_car.drive_forward(1);
    end
endmodule


/**output**/

//# door closed!
//# door opened!
//# door[1] is unlocked
//# Car with transmission: AUTOMATIC is moving forward