
class ltssm_monitor extends uvm_monitor;
    `uvm_component_utils(ltssm_monitor)

    virtual interface ltssm_if vif;
    uvm_analysis_port #(ltssm_txn) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual ltssm_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface must be set")
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.clk);
            if (vif.valid) begin
                ltssm_txn tx = ltssm_txn::type_id::create("tx");
                tx.ts_data = vif.ts_data;
                tx.valid = vif.valid;
                ap.write(tx);
            end
        end
    endtask
endclass
