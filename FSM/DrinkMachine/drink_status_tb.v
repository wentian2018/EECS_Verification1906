//testbench of the FSM


`'timescale 1ps / 1ps


module drink_status_tb;

    // Inputs
    reg reset;
    reg clk;
    reg one;
    reg half;

    // Outputs
    wire out;
    wire [1:0] cout;

    // Instantiate the Unit Under Test (UUT)
    drink_status_moore uut (
        .reset(reset),
        .clk(clk),
        .half(half),
        .one(one),
        .out(out),
        .cout(cout)
    );

    parameter CLK_PERIOD = 10;

    initial begin
        reset = 0;
        clk = 1;
        one = 0;
        half = 0;

        #100;
        reset = 1;

    end

    always #(CLK_PERIOD/2) clk = ~clk;

    always@(posedge clk or negedge reset) begin
      if(!reset)begin
        one = 1'b0;
        half = 1'b0;
      end
      else begin
        one = 1'b1;
        half = 1'b1;
      end
    end

endmodule
