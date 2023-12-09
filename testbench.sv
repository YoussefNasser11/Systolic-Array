`include "Matrix.sv"
`include "design.sv"
`timescale 1ns/1ps
module testbench #(parameter data_width=8) () ;

  bit                        t_clk     , t_rst;
  logic [data_width-1:0]     t_Cell_A1 , t_Cell_A2,t_Cell_A3;
  logic [data_width-1:0]     t_Cell_B1 , t_Cell_B2,t_Cell_B3;
  logic [(data_width*2):0]   t_cell_1  , t_cell_2 , t_cell_3 , t_cell_4 , t_cell_5;  
  logic [(data_width*2):0]   t_cell_6 , t_cell_7, t_cell_8, t_cell_9;
  Matrix M1,M2;
  //     int matrix_A[3][3];
  //   int matrix_B[3][3];

  Systolic_Array #(data_width) dut (t_clk, t_rst, t_Cell_A1, t_Cell_A2, t_Cell_A3, t_Cell_B1,
                                    t_Cell_B2,    t_Cell_B3, t_cell_1,  t_cell_2,  t_cell_3, 
                                    t_cell_4, t_cell_5, t_cell_6,t_cell_7, t_cell_8, t_cell_9);
  parameter clk_period = 10;

  // generate clock to sequence tests
  initial begin
    repeat(21) begin
      #(clk_period/2) t_clk = ~ t_clk;
    end
  end

  initial begin
    t_rst = 1;
    #(clk_period/5) t_rst = 0;
    M1 = new;
    M2 = new;
    $display("Matrix A is");
    M1.display;
    $display("Matrix B is");
    M2.display;
    //         for (int i = 0; i < 3; i++)
    //       for (int j = 0; j < 3; j++) begin
    //         matrix_A[i][j] = M1.matrix[i][j];
    //         matrix_B[i][j] = M2.matrix[i][j];
    //       end
  end

  task init_systolic_array(input int matrix_A[3][3], matrix_B[3][3]);


    // Initialize systolic array for matrix A
    #(clk_period/5);
    t_Cell_A1 = matrix_A[0][0]; t_Cell_A2 = 0; t_Cell_A3 = 0;
    t_Cell_B1 = matrix_B[0][0]; t_Cell_B2 = 0; t_Cell_B3 = 0;
    #clk_period;
    t_Cell_A1 = matrix_A[0][1]; t_Cell_A2 = matrix_A[1][0]; t_Cell_A3 = 0;
    t_Cell_B1 = matrix_B[1][0]; t_Cell_B2 = matrix_B[0][1]; t_Cell_B3 = 0;
    #clk_period;
    t_Cell_A1 = matrix_A[0][0]; t_Cell_A2 = matrix_A[1][1]; t_Cell_A3 = matrix_A[2][0];
    t_Cell_B1 = matrix_B[2][0]; t_Cell_B2 = matrix_B[1][1]; t_Cell_B3 = matrix_B[0][2];
    #clk_period;
    t_Cell_A1 = 0; t_Cell_A2 = matrix_A[1][2]; t_Cell_A3 = matrix_A[2][1];
    t_Cell_B1 = 0; t_Cell_B2 = matrix_B[2][1]; t_Cell_B3 = matrix_B[1][2];
    #clk_period;
    t_Cell_A1 = 0; t_Cell_A2 = 0; t_Cell_A3 = matrix_A[2][2];
    t_Cell_B1 = 0; t_Cell_B2 = 0; t_Cell_B3 = matrix_B[2][2];
    #clk_period;
    t_Cell_A1 = 0; t_Cell_A2 = 0; t_Cell_A3 = 0;
    t_Cell_B1 = 0; t_Cell_B2 = 0; t_Cell_B3 = 0;

    // Initialize systolic array for matrix B


  endtask

  int matrix_A[3][3] = '{'{7, 4, 7}, '{5, 6, 9}, '{1, 9, 5}};
  int matrix_B[3][3] = '{'{2, 5, 3}, '{7, 9, 5}, '{8, 5, 7}};

  initial begin //transaction
    init_systolic_array(matrix_A, matrix_B);

    #(2*clk_period)
    $display("at time %t Matrix Output is:", $time);
    $write("| %d | %d | %d |\n", t_cell_1, t_cell_2, t_cell_3);
    $write("| %d | %d | %d |\n", t_cell_4, t_cell_5, t_cell_6);
    $write("| %d | %d | %d |\n", t_cell_7, t_cell_8, t_cell_9);
  end


  initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
  end

endmodule

// ##################################################################################################################################################
//                                                             Systolic Array Algoerthim                                                          //
//##################################################################################################################################################

/*
output
# |     98 |    106 |     90 |
# |    124 |    124 |    108 |
# |    105 |    111 |     83 |



        _________
        0 0 0
        _________
        0 0 b9
        _________
        0 b8 b6
        _________
        b7 b5 b3
        _________
        b4 b2 0
        _________
        b1 0  0

 0 | 0|  0| a3| a2| a1 
   |  |   |   |   | 
 0 | 0| a6| a5| a4| 0 
   |  |   |   |   | 
 0 |a9| a8| a7|  0| 0 

*/

