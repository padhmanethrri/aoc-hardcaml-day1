
module day2_safe #(
    parameter DIAL_SIZE = 100,
    parameter STEP_W    = 32
)(
    input  wire              clk,
    input  wire              rst,
    input  wire              valid,
    input  wire              dir,      
    input  wire [STEP_W-1:0] steps,
    output reg  [31:0]       zero_count,
    output reg  [6:0]        pos
);

    wire [STEP_W-1:0] wraps;
    wire [STEP_W-1:0] rem;
    wire              cross_zero;
    wire [STEP_W-1:0] hits;

    assign wraps = steps / DIAL_SIZE;
    assign rem   = steps % DIAL_SIZE;

    
    assign cross_zero =
        (pos != 0) &&
        (dir
          ? ((pos + rem) >= DIAL_SIZE)   
          : (rem >= pos));               

    assign hits = wraps + (cross_zero ? 1 : 0);

    always @(posedge clk) begin
        if (rst) begin
            pos        <= 7'd50;
            zero_count <= 32'd0;
        end
        else if (valid) begin
            zero_count <= zero_count + hits;

            if (dir) begin
               
                pos <= (pos + rem >= DIAL_SIZE)
                     ? (pos + rem - DIAL_SIZE)
                     : (pos + rem);
            end
            else begin
             
                pos <= (pos >= rem)
                     ? (pos - rem)
                     : (pos + DIAL_SIZE - rem);
            end
        end
    end

endmodule
