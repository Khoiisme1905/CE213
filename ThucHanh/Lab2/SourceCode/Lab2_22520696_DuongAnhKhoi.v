module Lab2_22520696_DuongAnhKhoi(
	input [2:0] loaddata,
	input loadEn,
	input clk,
	output reg [2:0] count
);
	always @(posedge clk, posedge loadEn)
		if(loadEn)
			count <= loaddata;
		else
			if(count == 0)
				count <=6;
			else if (count ==6)
				count <= 4;
			else if (count == 4)
				count <= 7;
			else if (count ==7)
				count <= 3;
			else if (count == 3)
				count <= 0;
			else if (count == 1)
				count <= 6;
			else if (count == 5)
				count <= 2;
			else if (count ==2)
				count <= 7;
			else count <= 0;
endmodule
				