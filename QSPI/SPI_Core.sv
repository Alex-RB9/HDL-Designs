//When the processor reads data, the first 8 bits are data bits. and the 9th one is ready status signal.
//When the processor writes data, the first S-1 bits are the slave no. , next 8 bits are data bits. then the next 18 bits : first 16 is clk_divisor, 17th is cpol, 18th is cpha.
module SPI_Core 
    #(parameter S = 2;)//No of Slaves.
    (
    input logic clk,
    input logic rst,

    input logic write,//Write instruction.
    input logic [1:0] instr,//I use this to first write the slave no. and the data bits simultaneously, then I write the control bits(dvsr, cpol, cpha)
    input logic [31:0] wr_data,//The write data register, described above.
    output logic [31:0] rd_data,//This is fetched from the SPI after transmission.

    output logic spi_sclk,//This is used to synchronize with other chips(slaves).
    output logic spi_mosi,
    input logic spi_miso,
    output logic [S-1:0] spi_ss_n//The slave no.(A Demux can be used to drive the slave).
);

logic wr_en, wr_ss, wr_spi, wr_ctrl;
logic [17:0] ctrl_reg;
logic [S-1:0] ss_n_reg;
logic [7:0] spi_out;
logic spi_ready, cpol, cpha;
logic [15:0] dvsr;

SPI SPI_Unit(
    .clk(clk), 
    .reset(reset),
    .din(wr_data[7:0]),
    .dvsr(dvsr),
    .start(wr_spi),
    .cpol(cpol),
    .cpha(cpha),
    .dout(spi_out),
    .sclk(spi_sclk),
    .miso(spi_miso),
    .mosi(spi_mosi),
    .spi_done_tick(),
    .ready(spi_ready)
);

always_ff @( posedge clk, posedge reset ) begin
    if (reset) begin
        ctrl_reg <= 17'h0_0200;
        ss_n_reg <= {S{1'b1}};
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
assign spi_ss_n = ss_n_reg;
//The read data register.
assign rd_data = {23'b0, spi_ready, spi_out};
endmodule