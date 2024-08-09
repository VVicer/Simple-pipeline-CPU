`timescale 1ns / 1ps
module DataMemory(clk, reset, Address, Write_data, Read_data, MemRead, MemWrite, LEDData);
	input clk, reset;
	input [31:0] Address, Write_data;
	input MemRead, MemWrite;
	output [31:0] Read_data;
	output reg [1:0] LEDData;

	parameter RAM_SIZE = 512;
	parameter RAM_SIZE_BIT = 9;
	
	reg [31:0] RAM_data[RAM_SIZE - 1: 0];
	assign Read_data = MemRead ? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;
	
	integer j;
	integer i;
	initial begin
		LEDData <= 0;

		 for(i = 0; i < RAM_SIZE; i = i + 1) begin
              case(i)
                0: RAM_data[0] <= 32'h756e696c;
                1: RAM_data[1] <= 32'h6e736978;
                2: RAM_data[2] <= 32'h6e75746f;
                3: RAM_data[3] <= 32'h73697869;
                4: RAM_data[4] <= 32'h75746f6e;
                5: RAM_data[5] <= 32'h6978696e;
                6: RAM_data[6] <= 32'h746f6e73;
                7: RAM_data[7] <= 32'h78696e75; 
                100: RAM_data[100] <= 32'h78696e75;
                default: RAM_data[i] <= 32'h0;
              endcase
         end

		
	end

	always @(posedge reset or posedge clk)
		if (reset) begin
			LEDData <= 0;
             for(i = 0; i < RAM_SIZE; i = i + 1) begin
                case(i)
                    0: RAM_data[0] <= 32'h756e696c;
                    1: RAM_data[1] <= 32'h6e736978;
                    2: RAM_data[2] <= 32'h6e75746f;
                    3: RAM_data[3] <= 32'h73697869;
                    4: RAM_data[4] <= 32'h75746f6e;
                    5: RAM_data[5] <= 32'h6978696e;
                    6: RAM_data[6] <= 32'h746f6e73;
                    7: RAM_data[7] <= 32'h78696e75; 
                    100: RAM_data[100] <= 32'h78696e75;
                    default: RAM_data[i] <= 32'h0;
                endcase
             end
		end
		else if (MemWrite) begin
			if(Address == 32'h4000000C) begin
				LEDData <= Write_data[1:0];
			end
			else begin
				RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
			end
		end
		else begin
			LEDData <= LEDData;
		end
endmodule
