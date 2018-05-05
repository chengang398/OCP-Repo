
// s_ocp to slave memory interface bridge
import ocp_pkg::*;
module m_ocp_slave_bridge #(
  parameter int DATA_WIDTH = 32,
  parameter int ADDR_WIDTH = 5
) (
  input  logic                  clk,
  input  logic                  reset,
  input  logic                  enable,
  ocp_if.master                 m_ocp,
  input  logic                  mem_access_request,
  input  logic                  mem_access_type,
  input  logic [ADDR_WIDTH-1:0] mem_address,
  input  logic [DATA_WIDTH-1:0] mem_write_data,
  output logic [DATA_WIDTH-1:0] mem_read_data,
  output logic                  mem_access_complete,
  output logic                  busy
);
  
endmodule
