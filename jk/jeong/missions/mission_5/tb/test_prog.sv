program test_prog(input pclk, presetn, apb_interface apb_if);

test t0;

initial begin
    t0 = new(apb_if);
    @(negedge presetn);
    @(posedge presetn); 
    t0.run();
    $finish;
end

endprogram