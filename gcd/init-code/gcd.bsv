interface LGCD;
    method Action start(int a, int b);
    method int result();
    method Bool busy;
endinterface

module mkLGCD (LGCD);

    Reg#(int) x <- mkReg(0);
    Reg#(int) y <- mkReg(0);
    Reg#(Bool) bz <- mkReg(False);

    rule swapANDsub if (x<y);
    	x<=y;
	y<=x;
    endrule

    rule subtract if (x>=y);
    	x<=x-y;
    endrule
    
    rule stop if (x==0||y==0);
    	bz<=False;
    endrule

    
    method Action start(int a, int b); 
	if (a<=0||b<=0)
		$display("ERROR");
    	x<=a;
	y<=b;
	bz<=True;
    endmethod
    
    method int result if (bz==False);
    	return x;
    endmethod
    
    method Bool busy;
        return bz;
    endmethod

endmodule

