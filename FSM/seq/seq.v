module seq(in,out,next_state,clk,reset);

  input in,clk,reset;
  output       out;
  output [2:0] next_state;

  reg [2:0] cur_state;
  reg [2:0] next_state;

  wire out;

  parameter s0=1'd0,
            s1=1'd1,
            s2=1'd2,
            s3=1'd3,
            s4=1'd4,
            s5=1'd5,
            s6=1'd6,
            s7=1'd7;

//segment first : state transfer

  always @ ( posedge clk or negedge reset ) begin
    if (!reset) begin
      next_state <= s0 ;
    end else begin
      next_state <= cur_state ;
    end
  end

//segment Second :


always @ ( posedge clk or negedge reset ) begin
  if (!reset) begin
    next_state <= s0 ;
  end else case (cur_state)
      s0:begin
         if (in == 0) begin
           next_state <= s0;
         end else begin
           next_state <= s1;
         end
      end
      s1:begin
         if (in == 0) begin
           next_state <= s0 ;
         end else begin
           next_state <= s2 ;
         end
      end
      s2:begin
         if (in == 0) begin
           next_state <= s0 ;
         end else begin
           next_state <= s3 ;
         end
      end
      s3:begin
         if (in == 0) begin
           next_state <= s4 ;
         end else begin
           next_state <= s3 ;
         end
      end
      s4:begin
         if (in == 0) begin
           next_state <= s5 ;
         end else begin
           next_state <= s1 ;
         end
      end
      s5:begin
         if (in == 0) begin
           next_state <= s0 ;
         end else begin
           next_state <= s6 ;
         end
      end
      s6:begin
         if (in == 0) begin
           next_state <= s7 ;
         end else begin
           next_state <= s2 ;
         end
      end
      s7:begin
         if (in == 0) begin
           next_state <= s0 ;
         end else begin
           next_state <= s1 ;
         end
      end

    default: next_state <= s0 ;
  endcase
end

// Segment Third
assign out = (next_state == s7 ) ? 1 : 0 ;


endmodule
