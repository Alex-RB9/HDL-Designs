//When the processor reads data, the first 8 bits are data bits. and the 9th one is ready status signal.
//When the processor writes data, the first S-1 bits are the slave no. , next 8 bits are data bits. then the next 18 bits : first 16 is clk_divisor, 17th is cpol, 18th is cpha.
module SPI_Core 
    #(parameter S = 2;)//No of Slaves. 
    (
    input logic clk,
    input logic rst,

    input logic [15:0] t_hold,
    input logic [15:0] t_turn,
    input logic [15:0] t_setup,
    input logic write,//Write instruction.
    input logic [1:0] instr,//I use this to first write the slave no. and the data bits simultaneously, then I write the control bits(dvsr, cpol, cpha)
    input logic [31:0] wr_data,//The write data register, described above.
    output logic [31:0] rd_data,//This is fetched from the SPI after transmission.

    output logic spi_sclk,//This is used to synchronize with other chips(slaves).
    output logic spi_mosi,
    input logic spi_miso,
    output logic [S-1:0] spi_ss_n//The slave Selector.(01, 10). 11 being the null value. (Slaves are active-low.)
);

logic wr_en, wr_ss, wr_spi, wr_ctrl;
logic [17:0] ctrl_reg;
logic [S-1:0] ss_n_reg;
logic [7:0] spi_out;
logic spi_ready, cpol, cpha;
logic [15:0] dvsr;
logic s_en;

SPI SPI_Unit(
    .clk(clk), 
    .reset(reset),
    .din(wr_data[7:0]),
    .dvsr(dvsr),
    .start(wr_spi),
    .cpol(cpol),
    .cpha(cpha),
    .ss_h_cycle(t_hold),
    .ss_t_cycle(t_turn),
    .ss_s_cycle(t_setup),
    .dout(spi_out),
    .sclk(spi_sclk),
    .miso(spi_miso),
    .mosi(spi_mosi),
    .spi_done_tick(),
    .ready(spi_ready),
    .ss_n_out(s_en)
);

always_ff @( posedge clk, posedge reset ) begin
    if (reset) begin
        ctrl_reg <= 17'h200;//Hexadecimal equivalent of 512.
        ss_n_reg <= {S{1'b1}};//Repeats 1 "S" times.
    end
    else begin
        if (wr_ctrl)
            ctrl_reg <= wr_data[17:0];
        if(wr_ss)
            ss_n_reg <= wr_data[S-1:0];    
    end
end

assign wr_en = write;//First the Write instruction.
assign wr_ss = wr_en && instr[1:0]==2'b01;//Writing the Slave no.(The first S bits are now gone.)
assign wr_spi = wr_en && instr[1:0]==2'b10;//Writing to SPI.(Then the data bits.)
assign wr_ctrl = wr_en && instr[1:0]==2'b11;//Writing to Control Register.(Then the remaining 18 bits.)
//Further partitioning of the Control register.
assign dvsr = ctrl_reg[15:0];
assign cpol = ctrl_reg[16];
assign cpha = ctrl_reg[17];
//Using buffer to write Slave no.
assign spi_ss_n = ss_n_reg || {S{ss_en}};//When ss_en goes to 0. then we just do bitwise OR and see which line/path is equal to 0.
//The read data register.
assign rd_data = {23'b0, spi_ready, spi_out};
endmodule