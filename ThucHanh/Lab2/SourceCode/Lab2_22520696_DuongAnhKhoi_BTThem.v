module Lab2_22520696_DuongAnhKhoi_BTThem(
	input clk,
	input [31:0] ReadAdd1,
	input [31:0] ReadAdd2,
	input [31:0] WriteAdd,
	input [31:0] WriteData,
	input ReadWriteEn,
	output reg [31:0] ReadData1,
	output reg [31:0] ReadData2
);
	reg [31:0] regFile [31:0];
	always @(posedge clk) begin
	if (ReadWriteEn) begin
		regFile [WriteAdd] <= WriteData;
		ReadData1 <= regFile[ReadAdd1];
		ReadData2 <= regFile[ReadAdd2];
	end else begin
		ReadData1 <= 32'bz; 
		ReadData2 <= 32'bz;
		end
	end
endmodule