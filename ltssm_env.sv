
class ltssm_env extends uvm_env;
    `uvm_component_utils(ltssm_env)

    ltssm_driver drv;
    ltssm_monitor mon;
    ltssm_scoreboard sb;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv = ltssm_driver::type_id::create("drv", this);
        mon = ltssm_monitor::type_id::create("mon", this);
        sb = ltssm_scoreboard::type_id::create("sb", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        mon.ap.connect(sb.imp);
    endfunction
endclass
