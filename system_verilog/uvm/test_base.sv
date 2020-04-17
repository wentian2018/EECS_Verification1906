class test_base extends uvm_test;
  environment env;
  `uvm_component_utils( test_base );
  virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);
    env = environment::type_id::create("env", this);


  endfunction


endclass
