module counter_10 (
  input wire reset_n,
  input wire clock,
  input wire enable,
  input wire load,
  input wire [3:0] din,

  output reg [3:0] dout,
  output reg       cout
  );

  always @ ( posedge clock or negedge reset_n ) begin
    if (!reset_n) begin
      cout <= 1'b0;
      dout <= 4'b0;
    end else if (load) begin
      dout <= din ;
    end else if (enable) begin
      if (dout == 4'b1001) begin
        dout <= 4'b0000;
        cout <= cout + 1;
      end else begin
        dout <= dout + 1;
      end
    end
    else begin
      dout <= dout;
    end
  end

endmodule // counter_10
