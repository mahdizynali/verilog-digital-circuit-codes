module mux4to1(sel1, sel0, i0, i1, i2, i3 , f);
  input sel1, sel0, i0, i1, i2, i3;
  output f;
  wire w1, w2, w3, w4, nsel1, nsel0;

  not(nsel1, sel1);
  not(nsel0, sel0);
  and(w1, nsel1, nsel0, i0);
  and(w2, nsel1, sel0, i1);
  and(w3, sel1, nsel0, i2);
  and(w4, sel1, sel0, i3);
  or(f, w1, w2, w3, w4);
  
endmodule

module mux4to1_8bit(sel1, sel0, i0, i1, i2, i3 , f);
  input sel1, sel0;
  input [7:0]i3, i2, i1, i0;
  output [7:0]f;

  mux4to1 mux1(.sel1(sel1), .sel0(sel0), .i0(i0[0]), .i1(i1[0]), .i2(i2[0]), .i3(i3[0]), .f(f[0]));
  mux4to1 mux2(.sel1(sel1), .sel0(sel0), .i0(i0[1]), .i1(i1[1]), .i2(i2[1]), .i3(i3[1]), .f(f[1]));
  mux4to1 mux3(.sel1(sel1), .sel0(sel0), .i0(i0[2]), .i1(i1[2]), .i2(i2[2]), .i3(i3[2]), .f(f[2]));
  mux4to1 mux4(.sel1(sel1), .sel0(sel0), .i0(i0[3]), .i1(i1[3]), .i2(i2[3]), .i3(i3[3]), .f(f[3]));
  mux4to1 mux5(.sel1(sel1), .sel0(sel0), .i0(i0[4]), .i1(i1[4]), .i2(i2[4]), .i3(i3[4]), .f(f[4]));
  mux4to1 mux6(.sel1(sel1), .sel0(sel0), .i0(i0[5]), .i1(i1[5]), .i2(i2[5]), .i3(i3[5]), .f(f[5]));
  mux4to1 mux7(.sel1(sel1), .sel0(sel0), .i0(i0[6]), .i1(i1[6]), .i2(i2[6]), .i3(i3[6]), .f(f[6]));
  mux4to1 mux8(.sel1(sel1), .sel0(sel0), .i0(i0[7]), .i1(i1[7]), .i2(i2[7]), .i3(i3[7]), .f(f[7]));
endmodule

module logic_Unit_8bit(x, y, sel1, sel0, f);
  input [7:0]x, y;
  input sel0, sel1;
  output [7:0]f;
  wire [7:0]x_Or_y, x_And_y, x_Xor_y, x_Not;

  or(x_Or_y[0], x[0], y[0]);
  or(x_Or_y[1], x[1], y[1]);
  or(x_Or_y[2], x[2], y[2]);
  or(x_Or_y[3], x[3], y[3]);
  or(x_Or_y[4], x[4], y[4]);
  or(x_Or_y[5], x[5], y[5]);
  or(x_Or_y[6], x[6], y[6]);
  or(x_Or_y[7], x[7], y[7]);

  and(x_And_y[0], x[0], y[0]);
  and(x_And_y[1], x[1], y[1]);
  and(x_And_y[2], x[2], y[2]);
  and(x_And_y[3], x[3], y[3]);
  and(x_And_y[4], x[4], y[4]);
  and(x_And_y[5], x[5], y[5]);
  and(x_And_y[6], x[6], y[6]);
  and(x_And_y[7], x[7], y[7]);

  xor(x_Xor_y[0], x[0], y[0]);
  xor(x_Xor_y[1], x[1], y[1]);
  xor(x_Xor_y[2], x[2], y[2]);
  xor(x_Xor_y[3], x[3], y[3]);
  xor(x_Xor_y[4], x[4], y[4]);
  xor(x_Xor_y[5], x[5], y[5]);
  xor(x_Xor_y[6], x[6], y[6]);
  xor(x_Xor_y[7], x[7], y[7]);

  not(x_Not[0], x[0]);
  not(x_Not[1], x[1]);
  not(x_Not[2], x[2]);
  not(x_Not[3], x[3]);
  not(x_Not[4], x[4]);
  not(x_Not[5], x[5]);
  not(x_Not[6], x[6]);
  not(x_Not[7], x[7]);

  mux4to1_8bit m1(.sel1(sel1), .sel0(sel0), .i0(x_Or_y), .i1(x_And_y), .i2(x_Xor_y), .i3(x_Not), .f(f));
endmodule

module test_bench_logic_Unit_8bit;
  reg [7:0]x_t, y_t;
  reg s1, s0;
  wire [7:0]f_t;

  logic_Unit_8bit lu(.x(x_t), .y(y_t), .sel1(s1), .sel0(s0), .f(f_t));
  initial begin
    $monitor("x=%b, y=%b, sel1=%b, sel0=%b => f=%b", x_t, y_t, s1, s0, f_t);
    x_t=8'b01101100; y_t=8'b00010111; s1=1'b0; s0=1'b0;
    #10
    x_t=8'b01101100; y_t=8'b00010111; s1=1'b0; s0=1'b1;
    #10
    x_t=8'b01101100; y_t=8'b00010111; s1=1'b1; s0=1'b0;
    #10
    x_t=8'b01101100; y_t=8'b00010111; s1=1'b1; s0=1'b1; 
  end
endmodule
