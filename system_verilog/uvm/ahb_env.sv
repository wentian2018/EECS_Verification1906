class ahb_env extends uvm_env;
  master_agent m_agent;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    m_agent =  master_agent::type_id::create("m_agent",this);

    uvm_config_db #
    (uvm_object_wrapper)::set(this,"*.seqr.main_phase","default_sequence",transaction_sequence::get_type()
    );


  endfunction


endclass
