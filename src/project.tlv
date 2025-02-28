\m5_TLV_version 1d: tl-x.org
\m5
\SV
   module my_module (
      input wire clk,
      input wire reset,
      output reg [1:0] size
   );
      reg [7:0] weight;  // Define weight as a register
      always @(posedge clk or posedge reset) begin
         if (reset) begin
            weight <= 8'b0;
         end else begin
            weight <= weight + 1;  // Simple increment for testing
         end
      end
\TLV
   $size[1:0] = 
      $weight[7:0] >= 8'd64 ? 2'd3 : 
      $weight[7:0] >= 8'd56 ? 2'd2 : 
      2'd1;   
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   assign size = $size;  // Connect TL-Verilog to module output
   m5_makerchip_module  // Keep for Makerchip compatibility
   endmodule
