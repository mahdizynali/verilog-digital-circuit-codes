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

module test_fullAdder;

  reg x_1, y_1, cin_1;
  wire cout_1, sum_1;

  fullAdder fadder1(.x(x_1), .y(y_1), .cin(cin_1), .cout(cout_1), .sum(sum_1));
  initial begin
  $monitor("x=%b, y=%b, cin=%b => sum=%b, cout=%b ", x_1, y_1, cin_1, sum_1, cout_1);
  x_1=1'b0;y_1=1'b0;cin_1=1'b0;
  #10
  x_1=1'b0;y_1=1'b0;cin_1=1'b1;
  #10
  x_1=1'b0;y_1=1'b1;cin_1=1'b0;
  #10
  x_1=1'b0;y_1=1'b1;cin_1=1'b1;
  #10
  x_1=1'b1;y_1=1'b0;cin_1=1'b0;
  #10
  x_1=1'b1;y_1=1'b0;cin_1=1'b1;
  #10
  x_1=1'b1;y_1=1'b1;cin_1=1'b0;
  #10
  x_1=1'b1;y_1=1'b1;cin_1=1'b1;
  end
endmodule
