# Croc template for Nexys A7

## Generate bitstream

To create the vivado project:

```shell
vivado -mode tcl -script vivado.tcl
```

Then open the created project from `vivado_project`.

## Build software

Build the example in `croc/sw`.

## Load and debug

```shell
openocd -c "adapter driver cmsis-dap; cmsis_dap_vid_pid 0x2e8a 0x000c; transport select jtag; adapter speed 1000" \
        -c "jtag newtap riscv cpu -irlen 5 -expected-id 0x0c0c5db3" \
        -c "target create riscv.cpu riscv -chain-position riscv.cpu -coreid 0" \
        -c "init; halt" 
```

Connect with RISC-V gdb and load program.