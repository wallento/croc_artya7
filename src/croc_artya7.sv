module croc_artya7 #(
  parameter int unsigned GpioCount = 16
) (
  input  logic clk_i,
  input  logic rst,
  input  logic testmode_i,
  input  logic fetch_en_i,
  output logic status_o,

  input  logic jtag_tck_i,
  input  logic jtag_tdi_i,
  output logic jtag_tdo_o,
  input  logic jtag_tms_i,
  input  logic jtag_trst_ni,

  input  logic uart_rx_i,
  output logic uart_tx_o,

  inout  logic [GpioCount-1:0] gpio
);

    logic clk_sys;
    
    clk_wiz_0 u_clk(
        .clk_in1  (clk_i),
        .clk_out1 (clk_sys)
    );

    logic rst_ni;
    assign rst_ni = ~rst;

 logic [GpioCount-1:0] gpio_o;
 logic [GpioCount-1:0] gpio_out_en_o; 

    croc_soc u_soc(
        .clk_i (clk_sys),
        .rst_ni,

        .testmode_i,
        .fetch_en_i,
        .status_o,

        .jtag_tck_i,
        .jtag_tdi_i,
        .jtag_tdo_o,
        .jtag_tms_i,
        .jtag_trst_ni,

        .uart_rx_i,
        .uart_tx_o,

        .gpio_i (gpio),
        .gpio_o,
        .gpio_out_en_o
    );

    genvar i;
    generate
        for (i=0; i<GpioCount; i++) begin
            assign gpio[i] = gpio_out_en_o[i] ? gpio_o[i] : 1'bz;
        end
    endgenerate

endmodule