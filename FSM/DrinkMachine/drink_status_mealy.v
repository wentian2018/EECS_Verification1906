//Mealy FSM of Drink status

module drink_status_mealy (
  input clk,
  input one,
  input half,
  input reset,
  output out,
  output cout
  );


// 2 states less than  Moore FSM


  parameter [2:0] S0=3'b000,// 0
                  S1=3'b001,// 0.5
                  S2=3'b010,// 1
                  S3=3'b011,// 1.5
                  S4=3'b100,// 2


  reg [2:0] curr_state,
  reg [2:0] next_state,


  //first segment : state transfer

  always @ ( posedge clk or negedge reset ) begin
    if (!reset) begin
      curr_state <= S0;
    end else begin
      curr_state <= #1 next_state;
    end
  end

  //-------Second Segment Transfer condition


  always @ ( * ) begin
    case(curr_state)
      S0:begin
         if (half) begin
           next_state <= S1;
         end else if (one) begin
           next_state <= S2;
         end else begin
           next_state <= S0;
         end

      end
      S1:begin
         if (half) begin
           next_state <= S2;
         end else if (one) begin
           next_state <= S3;
         end else begin
           next_state <= S1;
         end

      end
      S2:begin
         if (half) begin
           next_state <= S3;
         end else if (one) begin
           next_state <= S4;
         end else begin
           next_state <= S2;
         end

      end
      S3:begin
         if (half) begin
           next_state <= S4;
         end else if (one) begin
           next_state <= S0;
         end else begin
           next_state <= S3;
         end

      end
      S4:begin
         if (half) begin
           next_state <= S0;
         end else if (one) begin
           next_state <= S0;
         end else begin
           next_state <= S4;
         end
      default: next_state <= S0;
    endcase
  end


  //-----Third Segemnt : State output


  assign out = ((curr_state == S4 ) & ( half | one ) ) ? 1 : ((curr_state == S3 ) & (one)) ? 1 : 0;
  assign cout = ((curr_state == S4 ) & (one)) ? 1 : 0;


endmodule //drink_status_mealy
