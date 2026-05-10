`timescale 1ns / 1ps 

module tb_traffic_fsm();

    // Testbench signals 
    reg clk;
    reg rst_n;           
    reg emergency; 
    wire [1:0] state;
 
    // State parameters for readability in the testbench 
    parameter RED    = 2'b00;
    parameter YELLOW = 2'b01; 
    parameter GREEN  = 2'b10;
 
    // Instantiate the Unit Under Test (UUT)
    traffic_fsm uut (
        .clk(clk),
        .rst_n(rst_n),   
        .emergency(emergency),
        .state(state)
    );
 
    // Clock generation (10ns period -> 100MHz)
    always #5 clk = ~clk;
 
    initial begin
        // Initialize signals 
        clk = 0;
        rst_n = 0;       // Assert reset (0 = Reset ON for active-low)
        emergency = 0;
 
        // Apply reset for 20ns
        #20;
        rst_n = 1;       // Release reset (1 = Reset OFF for active-low)
 
        $display("--- Starting Hidden Testbench ---");
 
        // TEST 1: Normal Cycle Verification
        // Expectation: 10 cycles Red (100ns), 15 cycles Green(150ns), 3 cycles Yellow (30ns) 
        #280; // Wait for one full cycle to complete (280ns)
 
        // TEST 2: Emergency during Green
        // Wait until we are back in the Green state (Red = 100ns, Green starts at 380ns)
        #150; // We should now be right in the middle of Green (at 450ns)
        emergency = 1;
 
        // Expectation: state jumps to YELLOW for exactly 1 cycle (10ns), then RED. 
        #50;
 
        // TEST 3: Emergency Recovery
        // Hold emergency high for a bit, then release
        #100;
        emergency = 0;
 
        // Expectation: The very next clock edge, state MUST jump from RED directly to GREEN.
 
        // TEST 4: The Tricky Edge Case
        // Assert emergency exactly when the state machine is naturally transitioning from Green to Yellow.
        // Recovery drops at ~600ns. Green lasts 15 cycles (150ns). 
        #145; // Right on the edge of Green ending! (at 745ns)
        emergency = 1;
 
        #50;
        emergency = 0;
 
        $display("--- Simulation Complete ---");
        $finish; 
    end

    // Monitor changes to console for quick organizer reference 
    initial begin
        // Using %s to print the string name of the state for easier reading in the console
        $monitor("Time: %0t | rst_n: %b | Emergency: %b | State: %b", 
                 $time, rst_n, emergency, state); 
    end

endmodule

