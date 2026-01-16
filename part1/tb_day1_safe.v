`timescale 1ns/1ps

module tb_day1_safe;

    reg clk = 0;
    always #5 clk = ~clk;

    reg rst;
    reg valid;
    reg dir;
    reg [15:0] amt;

    wire [6:0] pos;
    wire [31:0] result;

    integer fd;
    integer value;
    reg [7:0] ch;

    day1_safe dut (
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .dir(dir),
        .amt(amt),
        .pos(pos),
        .result(result)
    );

    initial begin
        rst   = 1;
        valid = 0;
        dir   = 0;
        amt   = 0;

        // reset
        repeat (2) @(posedge clk);
        rst = 0;

        // open input file
        fd = $fopen("input.txt", "r");
        if (fd == 0) begin
            $display("ERROR: input.txt not found");
            $finish;
        end

        // stream instructions
        while ($fscanf(fd, " %c%d", ch, value) == 2) begin
            @(negedge clk);
            dir   = (ch == "R" || ch == "r");
            amt   = value;
            valid = 1;

            @(posedge clk);   // instruction consumed

            @(negedge clk);
            valid = 0;

            @(posedge clk);   // allow state to settle
        end

        $fclose(fd);

        @(posedge clk);
        $display("FINAL PASSWORD = %0d", result);
        $finish;
    end

endmodule
