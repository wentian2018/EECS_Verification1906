//  Create alias for parameterized "string" type mailbox

typedef mailbox #(string) s_mbox;


class comp1;
  //Create a mailbox handle to put items
  s_mbox names;
  //Define a task to put items into the mailbox
  task send();
    for (int i=0; i < 3; i++) begin
      string s = $sformatf ("name_%0d", i);
        #1 $display("[%0t] Comp1 : Put %s", $time, s);
      names.put(s);
    end
  endtask
endclass

class comp2;

  //Create mailbox handle to get the items

  s_mbox list;

  // Create a loop that continuously gets an item from the maibox

  task receive();
    forever begin
      string s;
      list.get(s);
        $display("[%0t] Comp2 : Got %s", $time, s);
    end
  endtask
endclass
//connect both mailbox handle at a higher level 

module tb;  
  // Declare a global mailbox and create both components

  s_mbox m_mbx = new();
  comp1 m_comp1 = new();
  comp2 m_comp2 = new();

  initial begin
    //Assign both mailbox handles in components with the global mailbox
    //global mailbox

    m_comp1.names = m_mbx;
    m_comp2.list = m_mbx;



    fork
      m_comp1.send();
      m_comp2.receive();
    join
  
  end
endmodule

