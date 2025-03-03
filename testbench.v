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
      #500 $display("Simulation ended: size=%d", size);
      $finish;
   end
   
   initial $monitor("Time=%0t, weight=%d, size=%d", $time, dut.weight, size);
endmodule
