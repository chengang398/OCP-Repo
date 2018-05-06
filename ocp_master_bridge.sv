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
  input  logic                  mem_invalid_access,
  output logic                  busy
);
  
  logic s_cmd_wr;
  logic s_cmd_rd;
  
  always_ff @(posedge clk) begin
    if (reset) begin
      s_ocp.s_cmd_accept <= 1'b0;
    end else if (enable) begin
      s_ocp.s_cmd_accept <= !(s_ocp.s_cmd == S_CMD_IDLE);
    end else begin
      s_ocp.s_cmd_accept <= 1'b0;
    end
  end
  
  assign s_cmd_rd = s_ocp.s_cmd == S_CMD_RD;
  assign s_cmd_wr = s_ocp.s_cmd == S_CMD_WR;
  
  always_ff @(posedge clk) begin
    if (reset) begin
      mem_access_request <= 1'b0;
    end else if (enable && s_ocp.s_cmd_accept && (s_cmd_rd||s_cmd_wr)) begin
      mem_access_request <= 1'b1;
    end else begin
      mem_access_request <= 1'b0;
    end
  end
  
  always_ff @(posedge clk) begin
    if (enable && s_ocp.s_cmd_accept && (s_cmd_rd||s_cmd_wr)) begin
      mem_address <= s_ocp.m_addr;
    end
  end
  
  always_ff @(posedge clk) begin
    if (enable && s_ocp.s_cmd_accept && s_cmd_wr) begin
      mem_access_type <= 1'b1;
    end else begin
      mem_access_type <= 1'b0;
    end
  end
  
  always_ff @(posedge clk) begin
    if (enable && s_ocp.s_cmd_accept && s_cmd_wr) begin
      mem_write_data <= s_ocp.m_data;
    end
  end
  
  logic s_resp_valid;
  logic s_resp_error;
  
  assign s_resp_valid = s_ocp.s_resp == S_RESP_DVA;
  assign s_resp_error = s_ocp.s_resp == S_RESP_ERR;
  
  always_ff @(posedge clk) begin
    if (reset) begin
      s_ocp.s_resp <= S_RESP_NULL;
    end else if (enable && ~(s_resp_valid|s_resp_error) && mem_access_complete) begin
      s_ocp.s_resp <= mem_invalid_access ? S_RESP_ERR : S_RESP_DVA;
    end else if (enable && (s_resp_valid|s_resp_error) && s_ocp.m_resp_accept) begin
      s_ocp.s_resp <= S_RESP_NULL;
    end
  end
  
  always_ff @(posedge clk) begin
    if (enable && ~(s_resp_valid|s_resp_error) && mem_access_complete) begin
      s_ocp.s_data <= mem_read_data;
    end
  end
  
endmodule
