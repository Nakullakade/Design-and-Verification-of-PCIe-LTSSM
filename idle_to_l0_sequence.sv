
class idle_to_l0_sequence extends uvm_sequence #(ltssm_txn);
    `uvm_object_utils(idle_to_l0_sequence)

    function new(string name = "idle_to_l0_sequence");
        super.new(name);
    endfunction

    task body();
        ltssm_txn txn;
        txn = ltssm_txn::type_id::create("txn");
        txn.ts_data = 32'hDD_DD_DD_DD; // Transition to L0
        txn.valid = 1;
        start_item(txn);
        finish_item(txn);
    endtask
endclass
