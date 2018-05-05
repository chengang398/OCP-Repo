// MxN OCP interconnect
module ocp_mxn_interconnect #(
  parameter S_MSEL_WIDTH = 2,
  parameter S_CHANNEL_NO = 2**S_MSEL_WIDTH,
  parameter M_MSEL_WIDTH = 2,
  parameter M_CHANNEL_NO = 2**M_MSEL_WIDTH
) (
  input  logic clk,
  input  logic reset,
  input  logic enable,
  
  ocp_if.slave   s_ocp[S_CHANNEL_NO],
  ocp_if.master  m_ocp[M_CHANNEL_NO]
);
  
endmodule
