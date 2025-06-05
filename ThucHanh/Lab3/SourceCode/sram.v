module sram(
    input wire clk,
    input wire WriteEn,
    input wire ReadEn,
    input wire [5:0] Address,
    input wire [31:0] WriteData,
    output reg [31:0] ReadData
);

	reg	[31:0]	MEMORY[0:63];
	
	always@(posedge clk)
	begin
		if(WriteEn)
			MEMORY[Address] <= WriteData;
		else if(ReadEn)
					ReadData <= MEMORY[Address];
			  else	
					ReadData <= 32'b0;
	end
	
endmodule