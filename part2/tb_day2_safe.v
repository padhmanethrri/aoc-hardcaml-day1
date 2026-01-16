`timescale 1ns/1ps

module tb_day2_safe;

    reg         clk;
    reg         rst;
    reg         valid;
    reg         dir;
    reg [31:0]  steps;

    wire [31:0] zero_count;
    wire [6:0]  pos;

    integer fd;
    integer r;
    reg [8*32:1] line;
    reg [7:0]    dchar;
    integer      num;

    day2_safe dut (
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .dir(dir),
        .steps(steps),
        .zero_count(zero_count),
        .pos(pos)
    );

    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        rst   = 1;
        valid = 0;
        dir   = 0;
        steps = 0;

        repeat (2) @(posedge clk);
        rst = 0;

        fd = $fopen("input.txt", "r");
        if (fd == 0) begin
            $display("ERROR: could not open input.txt");
            $finish;
        end

        while (!$feof(fd)) begin
            r = $fgets(line, fd);
            if (r != 0) begin
                r = $sscanf(line, "%c%d", dchar, num);

                @(posedge clk);
                valid <= 1'b1;
                dir   <= (dchar == "L");
                steps <= num;

                @(posedge clk);
                valid <= 1'b0;
            end
            else begin
                @(posedge clk);
            end
        end

        $fclose(fd);

        repeat (5) @(posedge clk);

        $display("FINAL POSITION = %0d", pos);
        $display("PASSWORD       = %0d", zero_count);

        $finish;
    end

endmodule
