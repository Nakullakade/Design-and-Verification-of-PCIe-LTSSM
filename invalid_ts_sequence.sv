
class invalid_ts_sequence extends uvm_sequence #(ltssm_txn);
    `uvm_object_utils(invalid_ts_sequence)

    function new(string name = "invalid_ts_sequence");
        super.new(name);
    endfunction

    task body();
        ltssm_txn txn = ltssm_txn::type_id::create("txn");
        txn.ts_data = 32'hDE_AD_FA_11; // Invalid TS
        txn.valid = 1;
        start_item(txn);
        finish_item(txn);
    endtask
endclass
