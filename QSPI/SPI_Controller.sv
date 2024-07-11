module SPI (
    input logic [7:0]Din,
    input logic [15:0]ss_s_cycle,
    input logic [15:0]ss_h_cycle,
    input logic [15:0]ss_t_cycle,  
    input logic [15:0]dvsr,
    input logic clk, rst,
    input logic start, cpha, cpol, miso,
    output logic [7:0]Dout,
    output logic sclk,
    output logic spi_done_tick, ready,
    output logic mosi,
    output logic ss_n_out
);

typedef enum { Idle , ss_delay , cpha_delay , p0 , p1 } state;
state stt_reg, stt_next;
logic [15:0] c_reg, c_next;
logic [7:0] si_reg, si_next;
logic [7:0] so_reg, so_next;
logic [2:0] n_reg, n_next;
logic ready_i, spi_done_tick_i, ss_n_out_i;
logic sclk_reg, sclk_next;
logic pclk;

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        stt_reg <= Idle;
        c_reg <= 0;
        n_reg <= 0;
        si_reg <= 0;
        so_reg <= 0;
        sclk_reg <= 1'b0;
    end
    else begin
        stt_reg <= stt_next;
        c_reg <= c_next;
        n_reg <= n_next;
        si_reg <= si_next;
        so_reg <= so_next;
        sclk_reg <= sclk_next;
    end
end

always_comb begin 
    spi_done_tick_i = 1'b0;
    ss_n_out_i = 1'b1;
    ready_i = 1'b0;
    stt_next = stt_reg;
    c_next = c_reg;
    n_next = n_reg;
    si_next = si_reg;
    so_next = so_reg;
    sclk_next = sclk_reg;
    case (stt_reg)
        
        Idle: begin
            ready_i = 1'b1;
            if (start) begin
                c_next = 0;
                n_next = 0;
                stt_next = ss_delay;    
            end
        end

        ss_delay: begin
            if(n_reg == 0) begin
                if (c_reg == ss_s_cycle) begin
                    if (start) begin
                    so_next = Din;
                    ss_n_out_i = 1'b0;
                    if (cpha) stt_next = p0;
                    else stt_next = cpha_delay;
                    end
                end
                else c_next = c_next + 1;
            if(n_reg == 7) begin
                if (spi_done_tick == 0) begin
                   if (c_reg == ss_h_cycle) begin
                        spi_done_tick_i = 1'b1;
                        c_next = 0;
                   end
                   else c_next = c_next + 1;      
                end 
                else if (c_reg == ss_t_cycle) stt_next = idle;
                else c_next = c_next + 1;
            end            
            end
        end
        
        cpha_delay: begin
            if (c_reg == dvsr) begin
                c_next = 0;
                stt_next = p0;
            end
            else begin
                c_next = c_next + 1;
            end
        end
       
        p0: begin
            if (c_reg == dvsr) begin
                si_next = {miso, si_next[7:1]}; 
                c_next = 0;
                stt_next = p1;
            end
            else begin
                c_next = c_next + 1; 
            end
        end
        
        p1: begin
            if(c_reg == dvsr) begin
                if (n_reg == 7) begin
                    stt_next = ss_delay;
                end    
                else begin
                    so_next = {1'b0, so_next[7:1]};
                    c_next = 0;
                    stt_next = p0;
                end
            end
        end
    endcase
end

assign spi_done_tick = spi_done_tick_i;
assign ready = ready_i;
assign ss_n_out = ss_n_out_i;

assign pclk = (stt_next == p1 && ~cpha) || (stt_next == p0 && cpha); //I assume here that cpol is 0 by default.
//So when state is p1, then at cpha = 0, we get 1, else 0, and the reverse for state = p0. The reason why next stt's are used is to avoid delays.
assign sclk_next = (cpol) ? ~pclk : pclk; //This inverts the clk based on polarity.
//The signal is modified on the go, so we used a buffer(sclk_reg.)
assign Dout = si_reg;
assign mosi = so_reg[0];
assign sclk = sclk_reg;  

endmodule