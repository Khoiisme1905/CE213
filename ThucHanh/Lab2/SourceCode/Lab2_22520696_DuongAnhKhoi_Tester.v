`timescale 1 ns / 100 ps
module Lab2_22520696_DuongAnhKhoi_Tester();
	reg [2:0] loaddata;
	reg loadEn;
	reg clk;
	wire [2:0] count;
	initial begin
		clk=0;
		loadEn = 0;
		loaddata = 3'b000;
		// In ra header cho việc giám sát
      $display("Time\tloadEn\tloaddata\tcount");
      $monitor("%0t\t%b\t%d\t%d", $time, loadEn, loaddata, count);
		
        #10 loadEn = 1; loaddata = 3'b011; 
        #10 loadEn = 0;                    
		  
		  #200;
		  
		  loadEn = 1; loaddata = 3'b001;     
        #10 loadEn = 0;                    
        
        #200;
		  
		 loadEn = 1; loaddata = 3'b101;    
        #10 loadEn = 0;                    
        
        #200;
		  
		  #50 loadEn = 1; loaddata = 3'b000; 
        #10 loadEn = 0;               
        
        
		  
        #200;
		  
		  // Kết thúc mô phỏng
        $display("Testbench completed");
		  $finish;
    end
	 always #26.5 clk = ~clk;
	Lab2_22520696_DuongAnhKhoi U1(loaddata, loadEn, clk, count);
	
endmodule
	