# Smart-Intersection-Traffic-Controller_Verilog
FSM based Traffic Light Controller with Emergency Override
A Verilog HDL implementation of a traffic light controller using a finite state machine(FSM) with asynchronous reset and emergency vehicle override handling.
---
## Features
- FSM - based traffic signal controller
- Three Traffic States:
      - RED
      -GREEN
      -YELLOW
- Configurable Timing Logic
- Active Low Asynchronous Reset
- Asynchronous Emergency Override Signal
- Directed TestBench Verification
- Edge-case simulation testing

---

## FSM Operation

 ### Normal Traffic Cycle
 ```text
RED (10 cycles)
   ↓
GREEN (15 cycles)
   ↓
YELLOW (3 cycles)
   ↓
RED
```
---

# Emergency Handling

The controller supports an asynchronous emergency override signal for emergency vehicle prioritization.

## Emergency Behavior

| Current State | Action During Emergency |
|---|---|
| RED | Remains RED |
| GREEN | Transitions to YELLOW |
| YELLOW | Transitions to RED |
## Emergency Recovery

When the emergency signal is removed:

```text
RED → GREEN immediately
```

This allows traffic flow to resume quickly after emergency clearance.

---
# Timing Details

| State | Clock Cycles |
|---|---|
| RED | 10 cycles |
| GREEN | 15 cycles |
| YELLOW | 3 cycles |

Clock period used in simulation:

```text
10ns (100 MHz)
```

---

# Technologies Used

- Verilog HDL
- FSM-Based RTL Design
- Digital Logic Design
- Testbench Verification
- Simulation & Waveform Analysis
---
# Project Structure

```text
├── traffic_fsm.v        # RTL Design
├── tb_traffic_fsm.v     # Testbench
├── waveform.png         # Simulation waveform (optional)
└── README.md
```

---
# Testbench Coverage

The testbench validates:

- Normal traffic sequence
- Correct timing transitions
- Emergency during GREEN state
- Emergency during YELLOW state
- Emergency recovery behavior
- Edge-case timing transitions
- Reset behavior verification

---
 
  


