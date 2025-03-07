module testbench;
    reg clk;
    reg reset;
    wire error3;

    my_module dut (
        .clk(clk),
        .reset(reset),
        .error3(error3)
    );

    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
        #100 $finish;
    end

    always #5 clk = ~clk;
endmodule
