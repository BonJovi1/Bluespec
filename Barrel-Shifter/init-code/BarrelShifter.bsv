import Vector::*;


function Bit#(32) multiplexer32(Bit#(1) sel, Bit#(32) a, Bit#(32) b);
    
	return (sel == 0)?a:b; 

endfunction

function Bit#(32) logicalBarrelShifter(Bit#(32) operand, Bit#(5) shamt);
        Bit#(32) temp1=0;
	temp1[15:0]=operand[31:16];

	let ans1=multiplexer32(shamt[4],operand[31:0],temp1[31:0]);

	Bit#(32) temp2=0;
	temp2[23:0]=ans1[31:8];

	let ans2=multiplexer32(shamt[3],ans1[31:0],temp2[31:0]);

	Bit#(32) temp3=0;
	temp3[27:0]=ans2[31:4];

	let ans3=multiplexer32(shamt[2],ans2[31:0],temp3[31:0]);

	Bit#(32) temp4=0;
	temp4[29:0]=ans3[31:2];

	let ans4=multiplexer32(shamt[1],ans3[31:0],temp4[31:0]);

	Bit#(32) temp5=0;
	temp5[30:0]=ans4[31:1];

	let ans5=multiplexer32(shamt[0],ans4[31:0],temp5[31:0]);
	
    	return ans5;
endfunction

function Bit#(32) arithmeticBarrelShifter(Bit#(32) operand, Bit#(5) shamt);
   	Bit#(32) temp1=0;
	temp1[15:0]=operand[31:16];
	
	for(Integer i=16;i<32;i=i+1)
	begin
		temp1[i]=operand[31];
	end	

	let ans1=multiplexer32(shamt[4],operand[31:0],temp1[31:0]);

	Bit#(32) temp2=0;
	temp2[23:0]=ans1[31:8];
	
	for(Integer i=24;i<32;i=i+1)
	begin
		temp2[i]=operand[31];
	end	

	let ans2=multiplexer32(shamt[3],ans1[31:0],temp2[31:0]);

	Bit#(32) temp3=0;
	temp3[27:0]=ans2[31:4];

	for(Integer i=28;i<32;i=i+1)
	begin
		temp3[i]=operand[31];
	end	

	let ans3=multiplexer32(shamt[2],ans2[31:0],temp3[31:0]);

	Bit#(32) temp4=0;
	temp4[29:0]=ans3[31:2];

	for(Integer i=30;i<32;i=i+1)
	begin
		temp4[i]=operand[31];
	end	

	let ans4=multiplexer32(shamt[1],ans3[31:0],temp4[31:0]);

	Bit#(32) temp5=0;
	temp5[30:0]=ans4[31:1];
	temp5[31]=operand[31];

	let ans5=multiplexer32(shamt[0],ans4[31:0],temp5[31:0]);
    	return ans5;
endfunction

function Bit#(32) logicalLeftRightBarrelShifter(Bit#(1) shiftLeft, Bit#(32) operand, Bit#(5) shamt);
    	Bit#(32) temp0=0;
	temp0=operand;

	for(Integer i=0;i<32;i=i+1)
	begin
		operand[31-i]=temp0[i];
	end

	operand=multiplexer32(shiftLeft,temp0,operand);

	Bit#(32) temp1=0;
	temp1[15:0]=operand[31:16];

	let ans1=multiplexer32(shamt[4],operand[31:0],temp1[31:0]);

	Bit#(32) temp2=0;
	temp2[23:0]=ans1[31:8];

	let ans2=multiplexer32(shamt[3],ans1[31:0],temp2[31:0]);

	Bit#(32) temp3=0;
	temp3[27:0]=ans2[31:4];

	let ans3=multiplexer32(shamt[2],ans2[31:0],temp3[31:0]);

	Bit#(32) temp4=0;
	temp4[29:0]=ans3[31:2];

	let ans4=multiplexer32(shamt[1],ans3[31:0],temp4[31:0]);

	Bit#(32) temp5=0;
	temp5[30:0]=ans4[31:1];

	Bit#(32) ans5=multiplexer32(shamt[0],ans4[31:0],temp5[31:0]);

	temp0=ans5;

	for(Integer i=0;i<32;i=i+1)
	begin 
		ans5[31-i]=temp0[i];
	end

	ans5=multiplexer32(shiftLeft,temp0,ans5);
    return ans5;
endfunction

