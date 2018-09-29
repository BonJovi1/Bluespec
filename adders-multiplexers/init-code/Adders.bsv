import Multiplexer::*;
import BasicGates::*;
// Full adder functions

function Bit#(1) fa_sum( Bit#(1) a, Bit#(1) b, Bit#(1) c_in );
    return xor1( xor1( a, b ), c_in );
endfunction

function Bit#(1) fa_carry( Bit#(1) a, Bit#(1) b, Bit#(1) c_in );
    return or1( and1( a, b ), and1( xor1( a, b ), c_in ) );
endfunction

// 4 Bit full adder

function Bit#(5) add4( Bit#(4) a, Bit#(4) b, Bit#(1) c_in );
    	Bit#(4) sum;
        Bit#(5) carry=0;
        carry[0] = c_in;

        for(Integer i=0; i<4;i=i+1)
        begin
                sum[i]=fa_sum(a[i], b[i], carry[i]);
                carry[i+1]=fa_carry(a[i], b[i], carry[i]);
        end
        return {carry[4], sum};
endfunction

// 8 Bit ripple carry adder
function Bit#(9) add8( Bit#(8) a, Bit#(8) b, Bit#(1) c_in );
    	Bit#(8) sum;
        Bit#(5) inter1 = add4(a[3:0], b[3:0], c_in);
        Bit#(5) inter2 = add4(a[7:4], b[7:4], inter1[4]);

        for(Integer i=0; i<4; i=i+1)
        begin
                sum[i] = inter1[i];
                sum[i+4] = inter2[i];
        end
        return {inter2[4], sum};
endfunction

// 8 Bit carry select adder
function Bit#(9) cs_add8( Bit#(8) a, Bit#(8) b, Bit#(1) c_in );
    	Bit#(8) s;
        Bit#(5) s_mid1=add4(a[3:0],b[3:0],c_in);
        s[3:0]=s_mid1[3:0];
        Bit#(1) c4=s_mid1[4];
        Bit#(5) s_mid2=add4(a[7:4],b[7:4],0);
        Bit#(5) s_mid3=add4(a[7:4],b[7:4],1);
        s[7:4]=multiplexer4(c4,s_mid2[3:0],s_mid3[3:0]);
        Bit#(1) c8=and1(or1(c4,s_mid2[4]),s_mid3[4]);
        return{c8,s};
endfunction
