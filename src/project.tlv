\TLV_version 1d: tl-x.org
//
// Jason Kahn Lab 4.4
// Create a pipeline named comp.
// At various stages, define error flags that indicate specific conditions:
// Stage 1: bad_input and illegal_op. Combine these using an OR operation to create error1.
// Stage 3: Add an overflow condition. Combine it with error1 to create error2.
// Stage 6: Add a divide_by_zero condition. Combine this with error2 to create a final error3.
//
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
         $clk = clk;           // Explicit clock signal
         $in1[3:0] = 4'b1011;  // Example input 1 (11 decimal)
         $in2[3:0] = 4'b0000;  // Example input 2 (0 decimal)
         $op[1:0] = 2'b10;     // Example operation: 00=add, 01=sub, 10=div, 11=mul

      @1
         $bad_input = ($in1 > 4'd10) || ($in2 > 4'd10);  // Error if inputs > 10
         $illegal_op = ($op == 2'b11);                   // Error if op is 11 (invalid)
         $error1 = $bad_input || $illegal_op;            // Combine into error1

      @3
         $sum[4:0] = $in1 + $in2;                        // 5-bit sum to detect overflow
         $overflow = $sum[4];                            // Overflow if 5th bit is set
         $error2 = $overflow || $error1;                 // Combine with error1

      @6
         $divide_by_zero = ($op == 2'b10) && ($in2 == 4'b0000);  // Error if div by 0
         $error3 = $divide_by_zero || $error2;                   // Final error signal
         `BOGUS_USE($clk $reset)  // Silence unused signal warnings

      @6
         *error3 = $error3;

\SV
endmodule
