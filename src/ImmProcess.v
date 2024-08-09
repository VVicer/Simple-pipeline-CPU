`timescale 1ns / 1ps

module ImmProcess(ExtOp, LuiOp, Immediate, ImmExtOut, ImmExtShift); 

    input ExtOp; 
    input LuiOp; 

    input [15:0] Immediate;

    output [31:0] ImmExtOut;
    output [31:0] ImmExtShift;

    wire [31:0] ImmExt;
    
    assign ImmExt = {ExtOp? {16{Immediate[15]}}: 16'h0000, Immediate};
    assign ImmExtShift = ImmExt << 2;
    assign ImmExtOut = LuiOp? {Immediate, 16'h0000}: ImmExt;

endmodule
