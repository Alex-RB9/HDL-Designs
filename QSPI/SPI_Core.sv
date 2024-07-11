module SPI_Core (
    input logic clk,
    input logic rst,

    input logic cs,
    input logic write,
    input logic addr[4:0],
    input logic wr_data[31:0],
    output logic rd_data[31:0],

    output logic mosi,
    input logic miso,
    output logic [1:0] ss_n;
);
    
endmodule