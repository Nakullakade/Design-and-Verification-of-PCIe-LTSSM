
# LTSSM UVM Verification Project

This project verifies a simplified LTSSM (Link Training and Status State Machine) from the PCIe protocol using UVM.

## Structure

```
ltssm_uvm_project/
├── rtl/
│   └── ltssm_fsm.sv         # RTL design of LTSSM
├── tb/
│   ├── seq/
│   │   ├── ltssm_txn.sv     # Transaction class
│   │   ├── ts1_sequence.sv  # Valid TS sequence
│   │   ├── invalid_ts_sequence.sv  # Invalid transition test
│   │   └── idle_to_l0_sequence.sv  # Final state transition
```

## Sequences
- **ts1_sequence**: Drives TS1/TS2 to reach L0
- **invalid_ts_sequence**: Drives bad input to test recovery
- **idle_to_l0_sequence**: Drives idle to L0

## Next Steps
- Add UVM driver, monitor, scoreboard, environment, and test classes.
- Hook up the DUT and sequences in a UVM testbench.

## Author
Nakul — [GitHub](https://github.com/)
