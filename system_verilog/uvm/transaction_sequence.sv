class transaction_sequence extends uvm_sequence#(transaction);
  `uvm_object_utils(transaction_sequence)

  function new(string name = "transaction_sequence")
    super.new(name);
  endfunction

  virtual task body();
    if( starting_phase != null )
      starting_phase.raise_objection(this);
    repeat(10)begin
      `uvm_do(req);
    end
    if( starting_phase != null )
      starting_phase.drop_objection(this);
  endtask:body
  
endclass:transaction_sequence
