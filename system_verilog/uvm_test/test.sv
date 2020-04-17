
class hello extends uvm_test;

    `uvm_component_utils(hello)

    function new(string name , uvm_component parent);
      super.new(name,parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
      `uvm_info("Test","Hello UVM!",UVM_MEDIUM);
    
    endtask
    
endclass



