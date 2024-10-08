`timescale 1ns / 1ps

module PC(clk, reset, PC_i, PC_o);
    input reset;             
    input clk;
         
    input [31:0] PC_i;

    output reg [31:0] PC_o; 
    
    initial begin
        PC_o <= 0;
    end

    always@(posedge reset or posedge clk)
    begin
        if(reset) begin
            PC_o <= 0;
        end else begin
            PC_o <= PC_i;
        end
    end
endmodule