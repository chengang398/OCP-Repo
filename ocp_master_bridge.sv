// s_ocp to master memory interface bridge
import ocp_pkg::*;
module s_ocp_master_bridge #(
  parameter int DATA_WIDTH = 32,
  parameter int ADDR_WIDTH = 5
) (
  input  logic                  clk,
  input  logic                  reset,
  input  logic                  enable,
  ocp_if.slave                  s_ocp,
  output logic                  mem_access_request,
  output logic                  mem_access_type,
  output logic [ADDR_WIDTH-1:0] mem_address,
  output logic [DATA_WIDTH-1:0] mem_write_data,
  input  logic [DATA_WIDTH-1:0] mem_read_data,
  input  logic                  mem_access_complete,
  output logic                  busy
);
  
  always_ff @(posedge clk) begin
    if (reset) begin
      s_ocp.s_cmd_accept <= 1'b0;
    end else if (enable) begin
      s_ocp.s_cmd_accept <= !(s_ocp.s_cmd == S_CMD_IDLE);
    end else begin
      s_ocp.s_cmd_accept <= 1'b0;
    end
  end
  
endmodule
