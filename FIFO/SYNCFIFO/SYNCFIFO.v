//方法一 采用factor计数判断FIFO空满状态

 module SYNCFIFO (
   Fifo_rst,
   Clock,
   Read_enable,
   Write_enable,
   Write_data,
   Read_data,
   Full, //Full flag
   Empty,//empty flag
   Fcounter//count the number of data in FIFO
   );

   parameter  DATA_WIDITH = 8;
   parameter  ADDR_WIDITH = 9;

   input Fifo_rst;
   input Clock;
   input Read_enable;
   input Write_enable;
   input [DATA_WIDITH-1:0] Write_data;
   output [DATA_WIDITH-1:0] Read_data;
   output Full;
   output Empty;
   output [ADDR_WIDITH-1:0] Fcounter;


   reg [DATA_WIDITH-1:0] Read_data;
   reg Full;
   reg Empty;


   reg [ADDR_WIDITH-1:0] Fcounter;

   reg [ADDR_WIDITH-1:0] Read_addr;//read address
   reg [ADDR_WIDITH-1:0] Write_addr;//write address

   wire Read_allow = (Read_enable && !Empty) ;
   wire Write_allow = (Write_enable && !Full) ;

   dp_ram_inst dp_ram(

     .read_clock(Clock),
     .write_clock(Clock),
     .Read_enable(read_allow),
     .Write_enable(write_allow),
     .Read_data(read_data),
     .Write_data(write_data),
     .Write_addr(write_addr),
     .Read_addr(read_addr)
     );

  always @ ( posedge Clock or posedge Fifo_rst ) begin
    if (Fifo_rst) begin
      Empty <= 1'b1;
    end else begin
      Empty <= (!Write_enable && (Fcounter[8:1] == 8'b0) && ((Fcounter[0] == 1'b0) || Read_enable )) ;
      // all the bits is 0 or the high eight bits are 0 and the LSB is 1 with Read_enable
    end
  end

  always @ ( posedge Clock or posedge Fifo_rst ) begin
    if (Fifo_rst) begin
      Full <= 1'b1;
    end else begin
      Full <= (!Read_enable && (Fcounter[8:1] == 8'hFF) && ((Fcounter[0] == 1) || Write_enable));
      //all the bits is 1 or the high eight bits is 1 and the LSB is 0 with the Write_enable
    end
  end






 endmodule // SYNCFIFO
