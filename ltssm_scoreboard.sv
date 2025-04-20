
class ltssm_scoreboard extends uvm_component;
    `uvm_component_utils(ltssm_scoreboard)

    uvm_analysis_imp #(ltssm_txn, ltssm_scoreboard) imp;
    logic [3:0] state = 4'd0;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        imp = new("imp", this);
    endfunction

    function void write(ltssm_txn tx);
        case (state)
            4'd0: if (tx.ts_data == 32'hAA_AA_AA_AA) state = 4'd1;
            4'd1: if (tx.ts_data == 32'hBB_BB_BB_BB) state = 4'd2;
            4'd2: if (tx.ts_data == 32'hCC_CC_CC_CC) state = 4'd3;
            4'd3: state = 4'd4;
            4'd4: state = 4'd5;
            4'd5: if (tx.ts_data == 32'hDD_DD_DD_DD) state = 4'd6;
            default: state = 4'd7;
        endcase
        `uvm_info("SCOREBOARD", $sformatf("Current state: %0d", state), UVM_MEDIUM)
    endfunction
endclass
