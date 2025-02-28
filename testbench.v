module testbench;
   reg clk = 0;
   reg reset = 0;
   wire [1:0] size;
   
   my_module dut (
      .clk(clk),
      .reset(reset),
      .size(size)
   );
   
   always #5 clk = ~clk;  // 10-unit clock period
   
   initial begin
      reset = 1;
      #10 reset = 0;
      #500 $finish;  // Run for 50 cycles
   end
   
   initial $monitor("Time=%0t, size=%d", $time, size);
endmodule
