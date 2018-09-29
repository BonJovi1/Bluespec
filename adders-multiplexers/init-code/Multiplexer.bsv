import BasicGates::*;

function Bit#(1) multiplexer1(Bit#(1) sel, Bit#(1) a, Bit#(1) b);
    	Bit#(1) mid1=and1(not1(sel),a);
        Bit#(1) mid2=and1(sel,b);
        return or1(mid1,mid2);
endfunction

function Bit#(4) multiplexer4(Bit#(1) sel, Bit#(4) a, Bit#(4) b);
	Bit#(4) ans=0;
        for(Integer i=0;i<4;i=i+1)
        begin
                ans[i]=multiplexer1(sel,a[i],b[i]);
        end
        return ans;
endfunction

function Bit#(n) multiplexer_n(Bit#(1) sel, Bit#(n) a, Bit#(n) b);
        Bit#(n) ans=0;
        for(Integer i=0; i<valueOf(n);i=i+1)
        begin
                ans[i]=multiplexer1(sel,a[i],b[i]);
        end
        return ans;
endfunction
