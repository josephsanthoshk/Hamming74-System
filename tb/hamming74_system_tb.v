`timescale 1ns/1ps

module hamming74_system_tb;

    // Inputs
    reg  [3:0] data_in;
    reg        inject_error;
    reg  [2:0] error_pos;

    // Outputs
    wire [3:0] original_data;
    wire [6:0] encoded_data;
    wire [6:0] corrupted_data;
    wire [2:0] syndrome;
    wire [3:0] corrected_data;

    integer i;

    // =========================
    // DUT Instantiation
    // =========================
    hamming74_system dut (
        .data_in(data_in),
        .inject_error(inject_error),
        .error_pos(error_pos),

        .original_data(original_data),
        .encoded_data(encoded_data),
        .corrupted_data(corrupted_data),
        .syndrome(syndrome),
        .corrected_data(corrected_data)
    );

    // =========================
    // VCD Dump
    // =========================
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, hamming74_system_tb);
    end

    // =========================
    // Test Procedure
    // =========================
    initial begin

        $display("===============================================================");
        $display(" DATA | ENCODED | CORRUPTED | SYN | CORRECTED ");
        $display("===============================================================");

        // ------------------------------------------------
        // Test all inputs without errors
        // ------------------------------------------------
        inject_error = 0;
        error_pos    = 0;

        for(i = 0; i < 16; i = i + 1) begin
            data_in = i;
            #10;

            $display(" %b | %b | %b | %b | %b",
                     original_data,
                     encoded_data,
                     corrupted_data,
                     syndrome,
                     corrected_data);
        end

        // ------------------------------------------------
        // Test all single-bit errors
        // ------------------------------------------------
        data_in = 4'b1011;

        for(i = 0; i < 7; i = i + 1) begin

            inject_error = 1;
            error_pos    = i;

            #10;

            $display(" %b | %b | %b | %b | %b",
                     original_data,
                     encoded_data,
                     corrupted_data,
                     syndrome,
                     corrected_data);
        end

        // ------------------------------------------------
        // End Simulation
        // ------------------------------------------------
        #10;
        $display("===============================================================");
        $finish;

    end

endmodule
