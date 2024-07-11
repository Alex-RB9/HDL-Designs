module AddressData (
    input clk,
    input validADT, 
    input validData, 
    input validB,
    input [4:0]address,
    input [7:0]Data,
    output readyADT,
    output readyData,
    output readyB,
    output response,
    output [4:0]addr,
    output [7:0]dtt
);

localparam [1:0] idleAD = 2'b00,
                 RCADDR = 2'b01,
                 RCDATA = 2'b10,
                 SUTSFR = 2'b11;

reg c_stt, n_stt;
reg readyADTC, readyDataC, readyBC, responseC;
reg [4:0] addrC;
reg [7:0] dttC; 
reg readyADTN, readyDataN, readyBN, responseN;
reg [4:0] addrN;
reg [7:0] dttN;

always @(posedge clk) begin
    c_stt <= n_stt;
    readyADTC <= readyADTN;
    readyDataC <= readyDataN;
    readyBC <= readyBN;
    responseC <= responseN;
    addrC <= addrN;
    dttC <= dttN;
end

always @* begin
    n_stt = c_stt;
    readyADTN = readyADTC;
    readyDataN = readyDataC;
    readyBN = readyBC;
    responseN = responseC;
    addrN = addrC;
    dttN = dttC;
      
    case (c_stt)
        idleAD: begin
            if (validADT == 1'b1) begin
                n_stt = RCADDR;
            end
        end 
        RCADDR: begin
            readyADTN = 1'b1;
            if (validADT == 1'b1) begin
                addrN = address;
                readyADTN = 1'b0;
                n_stt = RCDATA;
            end
        end
        RCDATA: begin
            readyDataN = 1'b1;
            if (validData == 1'b1) begin
                dttN = Data;
                readyDataN = 1'b0;
                responseN = 1'b1;
                n_stt = SUTSFR;
            end
        end
        SUTSFR: begin
            readyBN = 1'b1;
            if (validB == 1'b1) begin
                responseN = 1'b0;
                readyBN = 1'b0;
                n_stt = idleAD;
            end
        end
    endcase
end

assign readyADT = readyADTC;
assign readyData = readyDataC;
assign readyB = readyBC;
assign response = responseC;
assign addr = addrC;
assign dtt = dttC;

endmodule
