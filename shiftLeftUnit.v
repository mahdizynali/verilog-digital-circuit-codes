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

module shiftLeftUnit(sel0,sel1, x, cin, f, cout, overflow);
	input [7:0] x;
	input cin,sel1,sel0;
	output cout, overflow;
	output [7:0] f;
	wire vx;
	
	buf(f[7],x[6]);
	buf(f[6],x[5]);
	buf(f[5],x[4]);
	buf(f[4],x[3]);
	buf(f[3],x[2]);
	buf(f[2],x[1]);
	buf(f[1],x[0]);
	
	xor(vx, x[7], x[6]);

  mux4to1 m1 (.sel1(sel1), .sel0(sel0), .i0(1'b0), .i1(x[7]), .i2(1'b0), .i3(cin), .f(f[0]));
  mux4to1 m2 (.sel1(sel1), .sel0(sel0), .i0(), .i1(), .i2(x[7]), .i3(), .f(cout));
  mux4to1 m3 (.sel1(sel1), .sel0(sel0), .i0(), .i1(), .i2(), .i3(vx), .f(overflow));
endmodule

module test_shift_left ;
	reg [7:0] a;
	reg s1,s0,ci;
	wire co, of;
	wire [7:0] result;
	shiftLeftUnit shifter_8_bit (.sel1(s1),.sel0(s0),.x(a),.cin(ci),.f(result),.cout(co), .overflow(of));
	initial begin
		a = 8'b10110101;
		{s1,s0} = 2'b00;
		ci = 1'b1;
		$monitor("x = %b s1,s0 = %b,%b cin = %b cout = %b overflow = %b",a,s1,s0,ci,co,of);
		#50
		{s1,s0} = 2'b01;
		$monitor("x = %b s1,s0 = %b,%b cin = %b cout = %b overflow = %b",a,s1,s0,ci,co,of);
		#50
		{s1,s0} = 2'b10;
		$monitor("x = %b s1,s0 = %b,%b cin = %b cout = %b overflow = %b",a,s1,s0,ci,co,of);
		#50
		{s1,s0} = 2'b11;
		$monitor("x = %b s1,s0 = %b,%b cin = %b cout = %b overflow = %b",a,s1,s0,ci,co,of);
	end
endmodule
