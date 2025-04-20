
class ltssm_txn extends uvm_sequence_item;
    rand logic [31:0] ts_data;
    rand bit valid;

    `uvm_object_utils(ltssm_txn)
    function new(string name = "ltssm_txn");
        super.new(name);
    endfunction
endclass
