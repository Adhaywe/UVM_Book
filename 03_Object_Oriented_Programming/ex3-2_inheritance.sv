//******************************************************************************************
// Design:      Inheritance Example
// 
// Description: 
//******************************************************************************************


module top;

    typedef enum {
        AUTOMATIC,
        MANUAL
    } trans_t;

    virtual class car;
        local trans_t m_trans;
        local bit     m_is_locked[];
        local bit     m_num_doors;

        task drive_forward();
        endtask

        task open_door(int door);
        endtask
    endclass

    virtual class sports_car extends car;
        local bit m_is_convertible;

        task drive_forward();
        endtask
    endclass

    class ferrari extends sports_car;
        task drive_forward();
            $display("%m() is executing");  // print the hierarchical name of the module, class, task or function that is executing the statement
        endtask
    endclass

    ferrari my_car;

    initial begin
        my_car = new();
        my_car.drive_forward();
    end
endmodule


/***output***/

// # top.ferrari.drive_forward() is executing