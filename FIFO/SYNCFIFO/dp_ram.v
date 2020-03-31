module dp_ram (
  write_clock,
  write_allow,
  read_clock,
  read_allow,
  write_addr,
  read_addr,
  write_data,
  read_data
  );

  //clock  to output delay
  //zero time delays can be confusing and somtimes cause problems

  parameter DLY = 1 ;
  parameter RAM_WIDTH = 8 ; //width of ram
  parameter RAM_DEPTH = 16 ;//depth of ram
  parameter ADDR_WIDITH = 4 ;//number of bits required to represent the ram address


  input write_clock;
  input read_clock;
  input write_allow;
  input read_allow;

  input [ADDR_WIDITH-1:0] write_addr;
  input [ADDR_WIDITH-1:0] read_addr;

  input [RAM_WIDTH-1:0] write_data;
  output [RAM_WIDTH-1:0] read_data;

  reg [RAM_WIDTH-1:0] read_data;

  reg [RAM_WIDTH-1:0] memory[RAM_DEPTH-1:0];


  //look  at the rising edge of the clock

  always @ ( posedge write_clock ) begin
    if (write_allow) begin

      memory[write_addr] <= write_data ;

    end

  end


  always @ ( posedge read_clock ) begin
    if (read_allow ) begin

      read_data <= memory[read_addr] ;
    end
  end



  input write_clock;


endmodule // dp_ram
