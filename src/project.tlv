\m5_TLV_version 1d: tl-x.org
\m5
// Define top-level Verilog module for size calculation
\SV
   module my_module (
      input wire clk,         // Clock input
      input wire reset,       // Reset input
      output reg [1:0] size   // Size output (2 bits)
   );
      reg [7:0] weight;       // Weight register (8 bits)
      always @(posedge clk or posedge reset) begin  // Sync logic
         if (reset) begin    // Reset condition
            weight <= 8'b0;   // Clear weight
         end else begin      // Normal operation
            weight <= weight + 1;  // Increment weight
         end
      end
// TL-Verilog logic for size based on weight
\TLV
   @0
      $reset = reset;       // Explicit reset signal
      $clk = clk;           // Explicit clock signal
      $size[1:0] = $reset ? 2'd1 :  // Default size 1 on reset
                   $weight[7:0] > 64 ? 2'd3 :  // Size 3 if weight > 64
                   $weight[7:0] > 56 ? 2'd2 :  // Size 2 if weight > 56
                   2'd1;                      // Default size 1
\SV_plus
   // Ensure $size is assigned to the Verilog output
   always @(posedge clk or posedge reset) begin
      if ($reset) size <= 2'd1;
      else size <= $size;
   end
   endmodule
