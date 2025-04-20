
class ts1_sequence extends uvm_sequence #(ltssm_txn);
    `uvm_object_utils(ts1_sequence)

    function new(string name = "ts1_sequence");
        super.new(name);
    endfunction

    task body();
        ltssm_txn txn;
        txn = ltssm_txn::type_id::create("txn");
        txn.ts_data = 32'hAA_AA_AA_AA; // DETECT -> POLLING_ACTIVE
        txn.valid = 1;
        start_item(txn);
        finish_item(txn);

        txn.ts_data = 32'hBB_BB_BB_BB; // POLLING_ACTIVE -> POLLING_CONFIG
        start_item(txn);
        finish_item(txn);

        txn.ts_data = 32'hCC_CC_CC_CC; // POLLING_CONFIG -> CONFIG_LANENUM_WAIT
        start_item(txn);
        finish_item(txn);

        txn.ts_data = 32'hDD_DD_DD_DD; // CONFIG_IDLE -> L0
        start_item(txn);
        finish_item(txn);
    endtask
endclass
