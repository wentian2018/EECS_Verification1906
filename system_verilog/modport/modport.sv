//Define  the interface
//---------------------//


interface mem_if (input wire clk)
  logic  reset;
  logic we_sys;
  logic cmd_valid_sys;
  logic ready_sys;
  logic [7:0] data_sys;
  logic [7:0] addr_sys;
  logic       we_mem;
  logic       ce_mem;
  logic [7:0] datao_mem;
  logic [7:0] datai_mem;
  logic [7:0] addr_mem;


  //-----------------------------------------------//
  //    modport fo memory controller endinterface  //
  //-----------------------------------------------//

  modport ctrl (input clk,reset,we_sys,cmd_valid_sys,addr_sys,datao_mem
                output we_mem,ce_mem,addr_mem,datai_mem,ready_sys,ref data_sys );



  //-----------------------------------------------//
  //    modport fo memory model endinterface  //
  //-----------------------------------------------//

  modport memory (input clk,reset,we_mem,ce_mem,addr_mem,datai_mem
                  output datao_mem);


  //-----------------------------------------------//
  //          modport for test program             //
  //-----------------------------------------------//

  modport test (input clk,ready_sys,
                output reset,we_sys,cmd_valid_sys,addr_sys,
                ref data_sys);

endinterface


 //+++++++++++++++++++++++++++++++++++++//
 // memory momdel design with interface //
 //+++++++++++++++++++++++++++++++++++++//

 module memory_model (mem_if.memory mif);
   // Memory Array
   logic [7:0] mem [0:255];


   //----Write logic----//

   always @ ( posedge mif.clk ) begin
     if (mif.we_mem && mif.ce_mem) begin
       mem[mif.addr_mem] <= mif.datai_mem ;
     end
   end

   //---------Read logic-------//

   always @ ( posedge mif.clk ) begin
     if (~mif.we_mem && mif.ce_mem) begin
       mif.datao_mem <= mem[mif.addr_mem] ;
     end
   end

 endmodule // memory_model


//----------------------------------------//
//Memory controller design with interface //
//----------------------------------------//

module memory_ctrl (mem_if.ctrl cif);

  typedef enmu {IDLE,WRITE,READ,DONE} fsm_t;

  fsm_t state;

  always @ ( posedge cif.clk ) begin
    if (cif.reset) begin
      state <= IDLE;
      cif.ready_sys <= 0;
      cif.we_mem <= 0 ;
      cif.ce_mem <= 0 ;
      cif.addr_mem <= 0 ;
      cif.datai_mem <= 0 ;
      cif.data_sys <= 8'bz ;

    end else begin
      case (state)
        IDLE: begin
          cif.ready_sys <= 1'b0;
          if (cif.cmd_valid_sys && cif.we_sys) begin
            cif.addr_mem <= cif.addr_sys ;
            cif.datai_mem <= cif.data_sys;
            cif.we_mem <= 1'b1 ;
            cif.ce_mem <= 1'b1 ;
            state <= WRITE ;
          end
          if (cif.cmd_valid_sys && ~cif.we_sys) begin
            cif.addr_mem <= cif.addr_sys ;
            cif.datai_mem <= cif.data_sys;
            cif.we_mem <= 1'b0 ;
            cif.ce_mem <= 1'b1 ;
            state <= READ ;
          end
        end
        WRITE:begin
          cif.ready_sys <= 1'b1 ;
          if (~cif.cmd_valid_sys) begin
            cif.addr_mem <= 8'b0 ;
            cif.datai_mem <= 8'b0 ;
            cif.we_mem <= 1'b0 ;
            cif.ce_mem <= 1'b0 ;
            state <= IDLE ;
          end
        end
        READ: begin
          cif.ready_sys <= 1'b1;
          cif.data_sys <= cif.datao_mem ;
          if (~cif.cmd_valid_sys) begin
            cif.addr_mem <= 8'b0 ;
            cif.datai_mem <= 8'b0 ;
            cif.we_mem <= 1'b0 ;
            cif.ce_mem <= 1'b0 ;
            cif.ready_sys <= 1'b1 ;
            state <= IDLE ;
            cif.data_sys <= 8'bz ;
          end
        end
        //default:   state <= IDLE ;
      endcase
    end
  end
endmodule // memory_ctrl

  program test (mem_if.test tif)
    initial begin
      tif.reset <= 1 ;
      tif.we_sys <= 0 ;
      tif.cmd_valid_sys <= 0 ;
      tif.addr_sys <= 0 ;
      tif.data_sys <= 8'bz ;
      #100
      tif.reset <= 0 ;
      for (int i = 0; i < 4 ; i++ ) begin
        @(posedge tif.clk);
        tif.addr_sys <= i ;
        tif.data_sys <= $random ;
        tif.cmd_valid_sys <= 1 ;
        tif.we_sys <= 1;
        @(posedge tif.ready_sys);
        $display("@%0dns Writing address %0d with data %0x",$time, i , tif.data_sys);
        @(posedge tif.clk);
        tif.addr_sys <= 0 ;
        tif.data_sys <= 8'bz ;
        tif.cmd_valid_sys <= 0 ;
        tif.we_sys <= 0 ;
      end
      repeat (10) @(posedge tif.clk);
      for (int i = 0; i < 4 ; i++ ) begin
        @(posedge tif.clk);
        tif.addr_sys <= i ;
        tif.cmd_valid_sys <= 1 ;
        tif.we_sys <= 0 ;
        @(posedge tif.ready_sys);
        @(posedge tif.clk);
        $display("@%0dns Reading address %0d, Got data %0X", $time, i, tif.data_sys);
        tif.addr_sys <= 0 ;
        tif.cmd_valid_sys <= 0 ;
      end
      #10 $finish;
    end

  endprogram



  module top ();

    logic clk = 0;
    always #10 clk++;

    //======================================//
    // Instance interface & DUT & program   //
    //======================================//

    mem_if         u_miff(clk);
    memory_ctrl    u_ctrl(u_miff);
    memory_model   u_model(u_miff);
    tes            u_test(u_miff);


  endmodule // top
