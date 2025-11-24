 
 
 

`timescale 1ns/1ps

module apb_completer #( parameter RW_REGION = 8,
                        parameter DATA_WIDTH = 32 ) (
    input logic                          pclk,
    input logic                          presetn,

    input logic  [RW_REGION - 1:0]       paddr,
    input logic                          pselx,
    input logic                          penable,
    input logic                          pwrite,
    input logic  [DATA_WIDTH - 1:0]      pwdata,

    output logic                         pready,
    output logic  [DATA_WIDTH - 1:0]     prdata,
    output logic                         pslverr
);

     
     
     

    logic [DATA_WIDTH - 1:0] mem [2**(RW_REGION) - 1:0];     
                                                             
                                                             

    logic enable_condition;  

    logic pre_pready;        
    logic [RW_REGION-1:0] temp_addr;  

     
     
     

    typedef enum logic [1:0] {
        IDLE   = 2'b00,
        SETUP  = 2'b01,
        ACCESS = 2'b10
    } t_state;

    t_state state, next_state;

    always_ff @(posedge pclk or negedge presetn) begin
        if (!presetn) state <= IDLE;
        else state <= next_state;
    end

    always_comb begin
        case (state)
            IDLE        : begin
                            if (pselx) next_state = SETUP;
                            else next_state = IDLE;
            end
            SETUP       : begin
                            if (penable) next_state = ACCESS;
                            else next_state = SETUP;
            end
            ACCESS      : begin
                            if (!pre_pready) next_state = ACCESS;
                            else if (pselx) next_state = SETUP;
                            else next_state = IDLE;
            end                          
            default     : next_state = IDLE;
        endcase
    end

    always_ff @(posedge pclk or negedge presetn) begin
        if (!presetn) pre_pready <= 0;
        else pre_pready <= pready;
    end
    /* Why pre_pready is used?
    If you detect next_state condition in ACCESS status, you will always get SETUP because
    pready will be always HIGH because of combinational logic, and 
    pselx will be always HIGH because of timing of detection.
    But, when you use pre_pready instead of pready,
    state machine will detect after transfer and ready for next_state*/

    // --------------------------------
    // APB pready processing
    // --------------------------------
    always_comb begin
        if (state == ACCESS) pready = 1;
        else pready = 0;
    end

    // --------------------------------
    // APB Write and Read Processing
    // --------------------------------
    always_ff @(posedge pclk or negedge presetn) begin
        if (!presetn) begin
            foreach (mem[i]) begin
                mem[i] = '0;
            end
        end else begin
            if (pwrite && pready) begin
                mem[paddr] <= pwdata;
            end
        end
    end

    always_ff @(posedge pclk or negedge presetn) begin
        if (!presetn) temp_addr <= '0;
        else temp_addr <= paddr;
    end

    assign prdata = mem[temp_addr];
    
    `ifdef VCS
    // --------------------------------
    // APB PSLVERR (optional)
    // --------------------------------

    initial begin
        enable_condition = 0;
        if ($test$plusargs("USE_VALID_ADDR"))
            enable_condition = 1;
        else 
            enable_condition = 0;
    end

    assign pslverr = (enable_condition & pselx & penable & pready) &&
                    !((paddr >= 'h00 && paddr <= 'h8F) || (paddr >= 'hC0 && paddr <= 'hFF));
    `endif

endmodule
