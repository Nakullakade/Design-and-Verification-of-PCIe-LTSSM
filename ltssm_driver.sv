
class ltssm_driver extends uvm_driver #(ltssm_txn);
    `uvm_component_utils(ltssm_driver)

    virtual interface ltssm_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual ltssm_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface must be set for: " + get_full_name())
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            ltssm_txn tx;
            seq_item_port.get_next_item(tx);
            vif.valid <= tx.valid;
            vif.ts_data <= tx.ts_data;
            @(posedge vif.clk);
            seq_item_port.item_done();
        end
    endtask
endclass
