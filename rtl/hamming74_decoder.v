module hamming74_decoder(
    input  [6:0] code_in,
    output [3:0] data_out,
    output [2:0] syndrome,
    output       error_detected
);

    reg [6:0] corrected_code;

    wire s1, s2, s4;

    // Syndrome calculation
    assign s1 = code_in[0] ^ code_in[2] ^ code_in[4] ^ code_in[6];
    assign s2 = code_in[1] ^ code_in[2] ^ code_in[5] ^ code_in[6];
    assign s4 = code_in[3] ^ code_in[4] ^ code_in[5] ^ code_in[6];

    assign syndrome = {s4, s2, s1};

    assign error_detected = |syndrome;

    // Error correction
    always @(*) begin
        corrected_code = code_in;

        if(syndrome != 3'b000)
            corrected_code[syndrome - 1] =
                ~corrected_code[syndrome - 1];
    end

    // Extract original data
    assign data_out = {
        corrected_code[2], // D3
        corrected_code[4], // D2
        corrected_code[5], // D1
        corrected_code[6]  // D0
    };

endmodule
