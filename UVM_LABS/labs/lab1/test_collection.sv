`ifndef TEST_COLLECTION__SV
`define TEST_COLLECTION__SV

// Lab 1: task 2, step 11 - bring in the environment class with: `include "router_env.sv"
//
// ToDo


// Lab 1: task 1, step 2 - Declare the class test_base that extends uvm_test
//
// ToDo


  // Lab 1: task 1, step 3 - register the class in factory via `uvm_component_utils macro
  //
  // ToDo


  // Lab 1: task 2, step 11 - Declare a handle named env of type router_env
  //
  // ToDo


  // Lab 1: task 1, step 4 - Create the constructor with two argument: string name, and uvm_component parent
  //                         Call super.new() with these two arguments
  //                         Lastly, print a message with: `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  //
  // ToDo



  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    // Lab 1: task 2, step 11 - Create a router environment object with: env = router_env::type_id::create("env", this);
    //
    // ToDo


  endfunction: build_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    // Lab 1: task 2, step 11 - Call uvm_top.print_topology() to the test topology
    // Note: If you want to see the topology as a tree format try: uvm_top.print_topology(uvm_default_tree_printer);
    //       Calling print_topology without any argument defaults to: print_topology(uvm_default_table_printer);
    //       Try out both foramts to see what the differences are
    //
    // ToDo


    // Lab 1: task 1, step 5 - Call factory.print() to see all classes registered with the factory
    //
    // ToDo


  endfunction: start_of_simulation_phase

endclass
`endif

