\TLV_version 1d: tl-x.org
\SV
module top(input wire clk, input wire reset, output wire error3);
   logic [31:0] cycle_count;  // Optional: for simulation visibility
   always_ff @(posedge clk) begin
      if (reset) cycle_count <= 0;
      else cycle_count <= cycle_count + 1;
   end

\TLV
   |comp
      @0
         $reset = reset;       // Explicit reset signal
         $clk = clk;           // Explicit clock signal (optional for Makerchip)

         // Define inputs to help avoid errors (example: 4-bit calculator)
         $in1[3:0] = 4'b1011;  // Example input 1 (11 decimal)
         $in2[3:0] = 4'b0000;  // Example input 2 (0 decimal)
         $op[1:0] = 2'b10;     // Example operation: 00=add, 01=sub, 10=div, 11=mult

      @1
         // Stage 1: Define error conditions
         $bad_input = ($in1 > 4'd10) || ($in2 > 4'd10);  // Error if inputs > 10
         $illegal_op = ($op > 2'b11);                    // Error if op is invalid
         $error1 = $bad_input || $illegal_op;            // Combine into error1

      @3
         // Stage 3: Define overflow (assuming addition for simplicity)
         $sum[4:0] = $in1 + $in2;                        // 5-bit sum to detect overflow
         $overflow = $sum[4];                            // Overflow if 5th bit is set
         $error2 = $overflow || $error1;                 // Combine with error1

      @6
         // Stage 6: Define divide-by-zero
         $divide_by_zero = ($op == 2'b10) && ($in2 == 4'b0000);  // Error if div by 0
         $error3 = $divide_by_zero || $error2;                   // Final error signal

      @6
         // Output to top-level module
         *error3 = $error3;

\SV
endmodule
