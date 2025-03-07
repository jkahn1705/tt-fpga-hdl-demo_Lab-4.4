`timescale 1ns / 1ps
module testbench;
    reg clk;
    reg reset;
    wire [1:0] size;

    my_module dut (
        .clk(clk),
        .reset(reset),
        .size(size)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Reset and test sequence
    initial begin
        reset = 1;
        #10 reset = 0; // Release reset after 10ns
        #200 $finish;  // End simulation after 200ns
    end

    // Monitor values (remove dut.weight since it's not an output)
    initial begin
        $monitor("Time=%0t, reset=%b, size=%b", $time, reset, size);
    end
endmodule
