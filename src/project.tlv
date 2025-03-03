\m5_TLV_version 1d: tl-x.org
\m5
\SV
   module my_module (
      input wire clk,
      input wire reset,
      output reg [1:0] size
   );
      reg [7:0] weight;
      reg [15:0] cyc_cnt;
      always @(posedge clk or posedge reset) begin
         if (reset) begin
            weight <= 8'b0;
            cyc_cnt <= 16'b0;
         end else begin
            weight <= weight + 1;
            cyc_cnt <= cyc_cnt + 1;
         end
      end
\TLV
   $size[1:0] = 
      $weight[7:0] >= 8'd64 ? 2'd3 : 
      $weight[7:0] >= 8'd56 ? 2'd2 : 
      2'd1;   
\SV
   assign size = $size;
   endmodule
