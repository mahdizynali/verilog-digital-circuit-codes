module mux4to1(sel1, sel0, i0, i1, i2, i3, f);
  input i0, i1, i2, i3, sel1, sel0;
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

module test_bench_mux4to1;
  reg i0_t,  i1_t, i2_t, i3_t;
  reg sel1_t, sel0_t;
  wire f_t;

  mux4to1 m(.sel1(sel1_t), .sel0(sel0_t), .i0(i0_t), .i1(i1_t), .i2(i2_t), .i3(i3_t), .f(f_t));
  initial begin
    $monitor("sel1=%b, sel0=%b, i0=%b, i1=%b, i2=%b, i3=%b f=%b ", sel1_t, sel0_t, i0_t, i1_t, i2_t, i3_t, f_t);
    sel1_t=1'b0; sel0_t=1'b0; i0_t=1'b1; i1_t=1'b0; i2_t=1'b0; i3_t=1'b0;
    #10
    sel1_t=1'b0; sel0_t=1'b1; i0_t=1'b0; i1_t=1'b1; i2_t=1'b0; i3_t=1'b0;
    #10
    sel1_t=1'b1; sel0_t=1'b0; i0_t=1'b0; i1_t=1'b0; i2_t=1'b1; i3_t=1'b0;
    #10
    sel1_t=1'b1; sel0_t=1'b1; i0_t=1'b0; i1_t=1'b0; i2_t=1'b0; i3_t=1'b1;
    #10
    sel1_t=1'b0; sel0_t=1'b0; i0_t=1'b0; i1_t=1'b1; i2_t=1'b1; i3_t=1'b1;
    #10
    sel1_t=1'b0; sel0_t=1'b1; i0_t=1'b1; i1_t=1'b0; i2_t=1'b1; i3_t=1'b1;
    #10
    sel1_t=1'b1; sel0_t=1'b0; i0_t=1'b1; i1_t=1'b1; i2_t=1'b0; i3_t=1'b1;
    #10
    sel1_t=1'b1; sel0_t=1'b1; i0_t=1'b1; i1_t=1'b1; i2_t=1'b1; i3_t=1'b0;   
  end
endmodule
