//module switch_led(
//input clk,
//    input  [3:0] sw,
//    output [3:0] led,
//    output Buzzer
//);

//reg [3:0] sw_prev;  // stores last state of switches
//reg [23:0] beep_counter;
//assign led[0] = sw[0];
//assign led[1] = sw[1];
//assign led[2] = sw[2];
//assign led[3] = sw[3];
//assign Buzzer =|sw;
//endmodule




module switch_led(
    input        clk,      // add clock
    input  [3:0] sw,
    output [3:0] led,
    output reg   Buzzer
);

assign led[0] = sw[0];
assign led[1] = sw[1];
assign led[2] = sw[2];
assign led[3] = sw[3];

reg [3:0] sw_prev;  // stores last state of switches
reg [23:0] beep_counter;  // controls beep duration

always @(posedge clk) begin
    sw_prev <= sw;  // remember previous state

    // detect ANY switch changing (on OR off)
    if (sw != sw_prev) begin
        beep_counter <= 24'd10000000;  // ~0.1 sec beep at 100MHz
        Buzzer <= 1;
    end else if (beep_counter > 0) begin
        beep_counter <= beep_counter - 1;
    end else begin
        Buzzer <= 0;  // beep done, turn off
    end
end

endmodule
