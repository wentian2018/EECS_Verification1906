class master_agent extends uvm_agent;

  transaction_sequencer seqr;
  driver srv;
  //utils macro and constructor not shown
  virtual function build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr = transaction_sequencer::type_id::create("seqr",this);
    drv = driver::type_id::create("drv",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction

endclass
