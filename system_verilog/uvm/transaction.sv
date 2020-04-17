class transaction extends uvm_sequence_item;
  rand bit [31:0] addr;
  constraint valid { data.size() inside { [2:100] }; }
  `uvm_object_utils_begin(transaction)
    `uvm_field_int(addr,UVM_ALL_ON)
    `uvm_field_queue_int(data,UVM_ALL_ON)
  `uvm_object_utils_end
  function new(string name = "transaction")
    super.new(name);
  endfunction

endclass
