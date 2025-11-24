program test_prog(input pclk, presetn, apb_interface apb_if);

test t0;

initial begin
    @(negedge presetn);
    @(posedge presetn);
    $finish;
end

endprogram