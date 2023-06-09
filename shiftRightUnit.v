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

module shiftRightUnit(sel0,sel1, x, cin, f, cout);
	input [7:0] x;
	input cin,sel1,sel0;
	output cout;
	output [7:0] f;
	wire [7:0] w1,w2,w3,w4;

	buf(w1[7],0);
	buf(w1[6],x[7]);
	buf(w1[5],x[6]);
	buf(w1[4],x[5]);
	buf(w1[3],x[4]);
	buf(w1[2],x[3]);
	buf(w1[1],x[2]);
	buf(w1[0],x[1]);

	buf(w2[7],x[0]);
	buf(w2[6],x[7]);
	buf(w2[5],x[6]);
	buf(w2[4],x[5]);
	buf(w2[3],x[4]);
	buf(w2[2],x[3]);
	buf(w2[1],x[2]);
	buf(w2[0],x[1]);
	
	buf(w3[7],cin);
	buf(w3[6],x[7]);
	buf(w3[5],x[6]);
	buf(w3[4],x[5]);
	buf(w3[3],x[4]);
	buf(w3[2],x[3]);
	buf(w3[1],x[2]);
	buf(w3[0],x[1]);
	buf(cout,x[0]);

	buf(w4[7],x[7]);
	buf(w4[6],x[7]);
	buf(w4[5],x[6]);
	buf(w4[4],x[5]);
	buf(w4[3],x[4]);
	buf(w4[2],x[3]);
	buf(w4[1],x[2]);
	buf(w4[0],x[1]);

	mux4to1_8bit shif(.sel1(sel1), .sel0(sel0), .i3(w4), .i2(w3), .i1(w2), .i0(w1), .f(f));
endmodule


module test_shift ;
	reg [7:0] a;
	reg s1,s0,ci;
	wire cout_t;
  wire [7:0] f_t;
	shiftRightUnit shifter_8_bit (.x(a),.cin(ci),.cout(cout_t),.sel1(s1),.sel0(s0),.f(f_t));
	initial begin
		a = 8'b10110101;
		{s1,s0} = 2'b00;
		ci = 1'b1;
		$monitor("x = %b s1,s0 = %b,%b f = %b",a,s1,s0,f_t);
		#50
		{s1,s0} = 2'b01;
		$monitor("x = %b s1,s0 = %b,%b f = %b",a,s1,s0,f_t);
		#50
		{s1,s0} = 2'b10;
		$monitor("x = %b s1,s0 = %b,%b cin = %b cout = %b f = %b ",a,s1,s0,ci,cout_t,f_t);
		#50
		{s1,s0} = 2'b11;
		$monitor("x = %b s1,s0 = %b,%b f = %b",a,s1,s0,f_t);
	end
endmodule
