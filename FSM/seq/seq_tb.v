`timescale 1ns/100ps
module seq_tb;

reg clk, reset;
reg [23:0] data;
wire [2:0] next_state;
wire in, out;

reg i ;

assign in = data[23];

initial begin
    clk = 1'b0;
    reset = 1'b0;
    #20 reset = 1'b1;

  //  #30 reset = 1'b0;
    data = 20'b1100_1001_0000_1001_0100;
    #20000 $finish;
end

always #20 clk = ~clk;//25Mhz clock

initial begin
  $readmemh("data.txt", data)
  for(i=0;i<=8;i=i+1) begin
    #40;
    in = data[i]
    $display("data=%d",data[i]);
  end
  #200;
  $finish;
end

always @(posedge clk)
    #2 data = {data[22:0], data[23]};

seq seq_inst(
    .in(in),
    .clk(clk),
    .reset(reset),
    .out(out),
    .next_state(next_state)
    );

endmodule
