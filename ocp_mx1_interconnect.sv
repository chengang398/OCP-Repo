// Mx1 OCP interconnect
module ocp_mx1_interconnect #(
  parameter S_MSEL_WIDTH = 2,
  parameter S_CHANNEL_NO = 2**S_MSEL_WIDTH
) (
  input  logic clk,
  input  logic reset,
  input  logic enable,
  
  ocp_if.slave   s_ocp[S_CHANNEL_NO],
  ocp_if.master  m_ocp
);
  
endmodule
