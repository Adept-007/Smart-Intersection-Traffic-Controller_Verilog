`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2026 15:30:34
// Design Name: 
// Module Name: traffic_fsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module traffic_fsm(input clk,
                   input rst_n,
                   input emergency,
                   output reg[1:0] state);
      parameter Red=2'b00,
                Yellow=2'b01,
                Green=2'b10;
  
    reg emergency_recovery;
reg [4:0] count;
always @(posedge clk or negedge rst_n or posedge emergency) begin
    if(!rst_n) begin
        state<=Red;
        count<=0;
        emergency_recovery<=0;
        end
   else if(emergency)begin
            emergency_recovery<=1;
            count<=0;
        case(state) 
        Red: state<=Red;
        Green:state<=Yellow;
        Yellow:state<=Red;
        default: state<=Red;
        endcase
        end
   else
         begin
                if(emergency_recovery) begin
                        emergency_recovery<=0;
                        state<=Green;
                        count<=0;
                end
                else begin
                    case(state)
                         Red: begin 
                            if(count==5'd9) begin
                                state<=Green;
                                count<=0;
                            end
                            else count<=count+1;
                          end
                        Green: begin
                            if(count==5'd14) begin
                                    count<=0;
                                    state<=Yellow;
                            end
                            else count<=count+1;
                          end
                        Yellow: begin
                                if(count==5'd2) begin
                                     count<=0;
                                     state<=Red;
                                end
                               else count<=count+1;
                            end
                    default:begin
                                state<=Red;
                                 count<=0;
                                end
    endcase
    end
    end
               
          
end

endmodule