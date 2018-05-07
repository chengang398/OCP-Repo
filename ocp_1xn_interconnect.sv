// 1xN OCP interconnect
module ocp_1xn_interconnect #(
  parameter M_MSEL_WIDTH = 2,
  parameter M_CHANNEL_NO = 2**M_MSEL_WIDTH
) (
  input  logic clk,
  input  logic reset,
  input  logic enable,
  
  ocp_if.slave   s_ocp,
  ocp_if.master  m_ocp[M_CHANNEL_NO]
);
  
endmodule
