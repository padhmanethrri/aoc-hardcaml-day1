module day1_safe #(
    parameter integer DIAL_SIZE = 100,
    parameter integer START_POS = 50
)(
    input  wire        clk,
    input  wire        rst,

    // streaming input
    input  wire        valid,
    input  wire        dir,      // 0 = Left, 1 = Right
    input  wire [15:0] amt,

    // state output
    output reg  [6:0]  pos,
    output reg  [31:0] result
);

    integer next_pos;

    always @(posedge clk) begin
        if (rst) begin
            pos    <= START_POS[6:0];
            result <= 0;
        end else if (valid) begin
            // compute next position
            if (dir)
                next_pos = pos + (amt % DIAL_SIZE);
            else
                next_pos = pos - (amt % DIAL_SIZE);

            // wrap modulo
            if (next_pos >= DIAL_SIZE)
                next_pos = next_pos - DIAL_SIZE;
            else if (next_pos < 0)
                next_pos = next_pos + DIAL_SIZE;

            pos <= next_pos[6:0];

            // count zero hits
            if (next_pos == 0)
                result <= result + 1;
        end
    end

endmodule
