module fir_filter_tb;

    reg clk, reset;
    reg signed [7:0] x_in;
    wire signed [15:0] y_out;

    // Instantiate the FIR filter
    fir_filter uut (
        .clk(clk),
        .reset(reset),
        .x_in(x_in),
        .y_out(y_out)
    );

    // Clock generation (10 ns period)
    always #5 clk = ~clk;

    // Dump VCD file for GTKWave
    initial begin
        $dumpfile("waveform.vcd");           // ✅ Corrected name
        $dumpvars(0, fir_filter_tb);         // ✅ Include all signals
    end

    // Monitor signals on the terminal
    initial begin
        $monitor("Time = %0t ns, reset = %b, x_in = %d, y_out = %d", $time, reset, x_in, y_out);
    end

    // Test sequence
    initial begin
        // Initialize
        clk = 0;
        reset = 1;
        x_in = 0;
        #10;

        reset = 0;

        // Apply input samples
        x_in = 8'd1;  #10;
        x_in = 8'd2;  #10;
        x_in = 8'd3;  #10;
        x_in = 8'd4;  #10;
        x_in = 8'd5;  #10;
        x_in = 8'd6;  #10;
        x_in = 8'd0;  #10;
        x_in = 8'd0;  #10;

        // Hold for final output
        #20;
        $display("Simulation done.");
        $finish;
    end

endmodule
