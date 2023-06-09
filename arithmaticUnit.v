module mux4to1 (sel0, sel1, i0, i1, i2, i3, f);
    input sel0, sel1, i0, i1, i2, i3;
    output f;
    wire w0, w1, w2, w3, nsel0, nsel1;
    
    and(w0, i0, nsel0, nsel1);
    and(w1, i1, sel0, nsle1);
    and(w2, i2, nsel0, sel1);
    and(w3, i3, sel0, sel1);
    or(f, w0,w1,w2,w3);
endmodule

module mux4to1_8bit (sel0, sel1, i0, i1, i2, i3, f);
    input [7:0] i0, i1, i2, i3;
    input sel0, sel1;
    output [7:0] f;
    
    mux4to1 mux1(.sel1(sel1), .sel0(sel0), .i0(i0[0]), .i1(i1[0]), .i2(i2[0]), .i3(i3[0]), .f(f[0]));
    mux4to1 mux2(.sel1(sel1), .sel0(sel0), .i0(i0[1]), .i1(i1[1]), .i2(i2[1]), .i3(i3[1]), .f(f[1]));
    mux4to1 mux3(.sel1(sel1), .sel0(sel0), .i0(i0[2]), .i1(i1[2]), .i2(i2[2]), .i3(i3[2]), .f(f[2]));
    mux4to1 mux4(.sel1(sel1), .sel0(sel0), .i0(i0[3]), .i1(i1[3]), .i2(i2[3]), .i3(i3[3]), .f(f[3]));
    mux4to1 mux5(.sel1(sel1), .sel0(sel0), .i0(i0[4]), .i1(i1[4]), .i2(i2[4]), .i3(i3[4]), .f(f[4]));
    mux4to1 mux6(.sel1(sel1), .sel0(sel0), .i0(i0[5]), .i1(i1[5]), .i2(i2[5]), .i3(i3[5]), .f(f[5]));
    mux4to1 mux7(.sel1(sel1), .sel0(sel0), .i0(i0[6]), .i1(i1[6]), .i2(i2[6]), .i3(i3[6]), .f(f[6]));
    mux4to1 mux8(.sel1(sel1), .sel0(sel0), .i0(i0[7]), .i1(i1[7]), .i2(i2[7]), .i3(i3[7]), .f(f[7]));
endmodule

module fullAdder(x, y, cin, cout, sum);
  input  x, y , cin;
  output cout, sum;
  wire w1, w2, w3;
  
  and(w1, x, y);
  and(w2, x, cin);
  and(w3, y, cin);
  xor(sum, x, y, cin);
  or(cout, w1, w2, w3);
  
endmodule

module fulladder_8bit (x, y, cin, cout, sum);
    input [7:0] x, y; 
    input cin;
    output cout;
    input [7:0] sum;
    wire [6:0]c;
    
    fullAdder f1(.x(x[0]), .y(y[0]), .cin(cin), .cout(c[0]), .sum(sum[0]));
    fullAdder f2(.x(x[1]), .y(y[1]), .cin(c[0]), .cout(c[1]), .sum(sum[1]));
    fullAdder f3(.x(x[2]), .y(y[2]), .cin(c[1]), .cout(c[2]), .sum(sum[2]));
    fullAdder f4(.x(x[3]), .y(y[3]), .cin(c[2]), .cout(c[3]), .sum(sum[3]));
    fullAdder f5(.x(x[4]), .y(y[4]), .cin(c[3]), .cout(c[4]), .sum(sum[4]));
    fullAdder f6(.x(x[5]), .y(y[5]), .cin(c[4]), .cout(c[5]), .sum(sum[5]));
    fullAdder f7(.x(x[6]), .y(y[6]), .cin(c[5]), .cout(c[6]), .sum(sum[6]));
    fullAdder f8(.x(x[7]), .y(y[7]), .cin(c[6]), .cout(cout), .sum(sum[7]));
endmodule

module arithmatic (x, y, cin, cout, sel0, sel1, f);
    input [7:0] x, y;
    input cin, sel0, sel1;
    output [7:0] f;
    output cout;
    wire [3:0] c;
    wire not_cin;
    wire [7:0] not_y, result0, result1, result2, result3;

    not(not_cin, cin);
    not(not_y[0], y[0]);
    not(not_y[1], y[1]);
    not(not_y[2], y[2]);
    not(not_y[3], y[3]);
    not(not_y[4], y[4]);
    not(not_y[5], y[5]);
    not(not_y[6], y[6]);
    not(not_y[7], y[7]);

    fulladder_8bit f0 (.x(x), .y(8'b00000000), .cin(cin), .cout(c[0]), .sum(result0));
    fulladder_8bit f1 (.x(x), .y(y), .cin(cin), .cout(c[1]), .sum(result1));
    fulladder_8bit f2 (.x(x), .y(not_y), .cin(not_cin), .cout(c[2]), .sum(result2));
    fulladder_8bit f3 (.x(x), .y(8'b11111111), .cin(cin), .cout(c[3]), .sum(result3));
    
    mux4to1_8bit m8 (.sel0(sel0), .sel1(sel1), .i0(result0), .i1(result1), .i2(result2), .i3(result3), .f(f));
    mux4to1 m4 (.sel0(sel0), .sel1(sel0), .i0(c[0]), .i1(c[1]), .i2(c[2]), .i3(c[3]), .f(cout));
    

endmodule

module test_bench_arithmatic();
    reg [7:0] x, y;
    reg cin, s0, s1;
    wire [7:0] f;
    wire cout;

    arithmatic a (.x(x), .y(y), .cin(cin), .cout(cout), .sel0(s0), .sel1(s1), .f(f));
    initial begin
        $monitor("x=%d y=%d cin=%d cout=%d sel0=%d sel1=%d f=%d",x, y, cin, cout, s0, s1, f);
        x=8'b01001010;y=8'b00100000;
        s0=1'b0;s1=1'b0;cin=1'b0;
        #5
        s0=1'b0;s1=1'b0;cin=1'b1;
        #5
        s0=1'b1;s1=1'b0;cin=1'b0;
        #5
        s0=1'b1;s1=1'b0;cin=1'b1;
        #5
        s0=1'b0;s1=1'b1;cin=1'b0;
        #5
        s0=1'b0;s1=1'b1;cin=1'b1;
        #5
        s0=1'b1;s1=1'b1;cin=1'b0;
        #5
        s0=1'b1;s1=1'b1;cin=1'b1; 
    end
endmodule
