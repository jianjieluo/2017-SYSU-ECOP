`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/25 08:48:39
// Design Name: 
// Module Name: cpu_sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu_sim();
    reg clk;
    reg rst;
    
    CPU uut(
        .clk(clk),
        .rst(rst)
        );
    
    always #30 clk = !clk;
    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        // Wait 100 ns for global reset to finish
        #60 rst = 1;
    end
endmodule
