
module ltssm_fsm(
    input logic clk,
    input logic rst_n,
    input logic valid,
    input logic [31:0] ts_data,
    output logic [3:0] state
);

typedef enum logic [3:0] {
    DETECT = 4'd0,
    POLLING_ACTIVE = 4'd1,
    POLLING_CONFIG = 4'd2,
    CONFIG_LANENUM_WAIT = 4'd3,
    CONFIG_COMPLETE = 4'd4,
    CONFIG_IDLE = 4'd5,
    L0 = 4'd6,
    RECOVERY = 4'd7
} ltssm_state_t;

ltssm_state_t current_state, next_state;
assign state = current_state;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        current_state <= DETECT;
    else
        current_state <= next_state;
end

always_comb begin
    next_state = current_state;
    case (current_state)
        DETECT:
            if (valid && ts_data == 32'hAA_AA_AA_AA)
                next_state = POLLING_ACTIVE;

        POLLING_ACTIVE:
            if (valid && ts_data == 32'hBB_BB_BB_BB)
                next_state = POLLING_CONFIG;

        POLLING_CONFIG:
            if (valid && ts_data == 32'hCC_CC_CC_CC)
                next_state = CONFIG_LANENUM_WAIT;

        CONFIG_LANENUM_WAIT:
            next_state = CONFIG_COMPLETE;

        CONFIG_COMPLETE:
            next_state = CONFIG_IDLE;

        CONFIG_IDLE:
            if (valid && ts_data == 32'hDD_DD_DD_DD)
                next_state = L0;

        default: next_state = RECOVERY;
    endcase
end

endmodule
