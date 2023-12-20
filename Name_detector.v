`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IIT Jammu
// Engineer: Manish Kumar
// Contact details: 2021uee0146@iitjammu.ac.in
//
// Create Date: 10.11.2023 11:13:43
// Design Name: Name Detector using Verilog
// Module Name: Name_Detector2
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module Name_Detector2(
input clk, 
input reset,
  input [7:0] data, // ASCII Input
  output [87:0] out // 11 letters output in ASCII format
    );
    
    parameter s0 = 4'd0, // States for state transitions
     s1 = 4'd1, 
     s2 = 4'd2, 
     s3 = 4'd3, 
     s4 = 4'd4, 
     s5 = 4'd5, 
     s6 = 4'd6, 
     s8 = 4'd8, 
     s9 = 4'd9, 
     s10 = 4'd10, 
     s11 = 4'd11, 
     s12 = 4'd12, 
     s13 = 4'd13; // completely detected
     
     reg [3:0] cs, ns;
     
     
     assign out = (cs == s13) ?
     {88'b0011001000110000001100100011000101010101010001010100010100110000001100010011010000110110}: // 2021UEE0146
                  (cs == s6 || cs == s8 || cs == s9 || cs == s10 || cs == s11 || cs == s12) ?
     {80'b01010101010001110101111101000101010001010101111100110010001100000011001000110001, 8'b0}: // UG_EE_2021
     {72'b010010010100100101010100001000000100101001100001011011010110110101110101, 16'd0}; // IIT Jammu
                  
     
     
     always @(posedge clk) begin
        if(reset) cs <= s0;
        else cs <= ns;
     end
     
     always@(cs, data)  begin
        case(cs)
            s0 : ns <= (data == 8'd77)? s1:s0; // M
            
            s1 : begin
                if (data == 8'd97) ns = s2;  // Ma
                else if (data == 8'd77) ns = s1;  // M
                else ns <= s0;  // Nothing
            end
            
            s2 : begin
                if (data == 8'd110) ns = s3;  // Man
                else if (data == 8'd77) ns = s1;  // M
                else ns <= s0;  // Nothing
            end
            
            s3 : begin
                if(data == 8'd105) ns = s4;  // Mani
                else if (data == 8'd77) ns = s1;  // M
                else ns <= s0;  // Nothing
            end
            
            s4 : begin
                if(data == 8'd115) ns = s5;  // Manis
                else if (data == 8'd77) ns = s1;  // M
                else ns <= s0;  // Nothing
            end
            
            s5 : begin
                if(data == 8'd104) ns = s6;  // Manish   (Output should be batch)
                else if (data == 8'd77) ns = s1;  // M
                else ns <= s0;  // Nothing
            end
            
            s6 : begin
                if(data == 8'd32) ns = s8;  // Manish(space) (Output should be batch)
                else if (data == 8'd77) ns = s1; // M
                else ns <= s0;  // Nothing 
            end
            
            s8 : begin
                if(data == 8'd75) ns = s9;  // Manish K  (Output should be batch)
                else if (data == 8'd77) ns = s1;  // M
                else ns <= s0;
            end
            
            s9 : begin
                if(data == 8'd117) ns = s10;  // Manish Ku
                else if (data == 8'd77) ns = s1;  // M
                else ns <= s0;
            end
            
            s10 : begin
                if(data == 8'd109) ns = s11;  // Manish Kum
                else if (data == 8'd77) ns = s1;  // M
                else ns <= s0;
            end
            
            s11 : begin
                if(data == 8'd97) ns = s12; // Manish Kuma
                else if (data == 8'd77) ns = s1; // M
                else ns <= s0;
            end
            
            s12 : begin
                if(data == 8'd114) ns = s13;  // Manish Kumar
                else if (data == 8'd77) ns = s1;  // M
                else ns <= s0;
            end
            
            s13 : begin
                if(data == 8'd77) ns = s1;  // M
                else ns <= s0;
            end
            
            default: 
                ns <= s0; 
        endcase
     end
endmodule

