module hamming74_encoder(
    input  [3:0] data_in,
    output [6:0] code_out
);

    wire p1, p2, p4;

    assign p1 = data_in[3] ^ data_in[2] ^ data_in[0];
    assign p2 = data_in[3] ^ data_in[1] ^ data_in[0];
    assign p4 = data_in[2] ^ data_in[1] ^ data_in[0];

    assign code_out = {
        data_in[0], 
        data_in[1],
        data_in[2], 
        p4,         
        data_in[3], 
        p2,         
        p1          
    };

endmodule
