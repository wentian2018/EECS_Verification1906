class driver extends uvm_dirver # (transaction);
  `uvm_component_utils(driver)
  function new (string name , uvm_component parent)
    super.new(name , parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info("DRV_RUN",req.sprint(),UVM_MEDIUM);
      seq_item_port.item_done();
    end
  endtask
endclass
