
class ltssm_test extends uvm_test;
    `uvm_component_utils(ltssm_test)

    ltssm_env env;
    ts1_sequence seq;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = ltssm_env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        seq = ts1_sequence::type_id::create("seq");
        seq.start(env.drv);
        phase.drop_objection(this);
    endtask
endclass
