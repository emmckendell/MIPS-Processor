`timescale 1ns / 1ps

module signExtend(
    input wire [15:0] inUnextend_16b,
    output wire [31:0] outExtend_32b
    );
    
    // sign extend MSB of 16-bits 16 times to extend to 32-bits
    // only 32'hFFFF_xxxx OR 32'h0000_xxxx
    assign outExtend_32b = {{16{inUnextend_16b[15]}}, inUnextend_16b[15:0]};
endmodule