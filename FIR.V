module fir_filter (
    input clk,
    input reset,
    input signed [7:0] x_in,
    output reg signed [15:0] y_out
);

    // Coefficients (example: h = [1, 2, 3, 4])
    parameter signed [7:0] h0 = 8'd1;
    parameter signed [7:0] h1 = 8'd2;
    parameter signed [7:0] h2 = 8'd3;
    parameter signed [7:0] h3 = 8'd4;

    // Shift register for input samples
    reg signed [7:0] x [0:3];

    integer i;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 4; i = i + 1)
                x[i] <= 0;
            y_out <= 0;
        end else begin
            // Shift input samples
            x[3] <= x[2];
            x[2] <= x[1];
            x[1] <= x[0];
            x[0] <= x_in;

            // Compute filter output
            y_out <= h0*x[0] + h1*x[1] + h2*x[2] + h3*x[3];
        end
    end
endmodule
