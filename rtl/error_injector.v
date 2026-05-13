module error_injector(
    input  [6:0] code_in,
    input  [2:0] error_pos,
    input        enable,
    output [6:0] code_out
);

    reg [6:0] error_mask;

    always @(*) begin
        error_mask = 7'b0000000;

        if(enable)
            error_mask[error_pos] = 1'b1;
    end

    assign code_out = code_in ^ error_mask;

endmodule
