module hamming74_system(
    input  [3:0] data_in,
    input        inject_error,
    input  [2:0] error_pos,

    output [3:0] original_data,
    output [6:0] encoded_data,
    output [6:0] corrupted_data,
    output [2:0] syndrome,
    output [3:0] corrected_data
);

    // Internal wires
    wire [6:0] encoded_wire;
    wire [6:0] corrupted_wire;

    // =========================
    // Encoder
    // =========================
    hamming74_encoder encoder_inst (
        .data_in(data_in),
        .code_out(encoded_wire)
    );

    // =========================
    // Error Injector
    // =========================
    error_injector injector_inst (
        .code_in(encoded_wire),
        .error_pos(error_pos),
        .enable(inject_error),
        .code_out(corrupted_wire)
    );

    // =========================
    // Decoder
    // =========================
    hamming74_decoder decoder_inst (
        .code_in(corrupted_wire),
        .data_out(corrected_data),
        .syndrome(syndrome),
        .error_detected()
    );

    // =========================
    // Outputs
    // =========================
    assign original_data  = data_in;
    assign encoded_data   = encoded_wire;
    assign corrupted_data = corrupted_wire;

endmodule
