
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
  
  typedef enum logic [1:0] {
    IDLE,WR_ACTIVE,RD_ACTIVE,DONE
  } state_type;
  state_type state;
  
  always_ff @(posedge clk) begin
    if (reset) begin
      m_ocp.m_cmd <= 3'b000; // IDLE
    end else if (enable) begin
      if (mem_access_request && state == IDLE) begin
        m_ocp.m_cmd <= mem_access_type ? 3'b001 : 3'b010; // RD/WR
      end else if (m_ocp.m_cmd != 3'b000 && m_ocp.s_cmd_accept) begin
        m_ocp.m_cmd <= 3'b000; // IDLE
      end
    end
  end
  
  always_ff @(posedge clk) begin
    if (enable) begin
      if (mem_access_request && state == IDLE) begin
        m_ocp.m_addr <= mem_address;
        m_ocp.m_data <= mem_write_data;
      end
    end
  end
  
  always_ff @(posedge clk) begin
    if (reset) begin
      m_ocp.m_resp_accept <= 1'b0;
    end else if (enable) begin
      if (~m_ocp.m_resp_accept && m_ocp.m_cmd != 3'b000 && m_ocp.s_cmd_accept) begin
        m_ocp.m_resp_accept <= 1'b1;
      end else if (m_ocp.m_resp_accept && m_ocp.s_resp != 2'b00) begin
        m_ocp.m_resp_accept <= 1'b0;
      end
    end
  end
  
  always_ff @(posedge clk) begin
    if (reset) begin
      mem_access_done <= 1'b0;
    end else if (enable) begin
      if (m_ocp.s_resp != 2'b00 && m_ocp.m_resp_accept) begin
        mem_access_done <= 1'b1;
      end else begin
        mem_access_done <= 1'b0;
      end
    end
  end
  
  always_ff @(posedge clk) begin
    if (enable) begin
      if (m_ocp.s_resp != 2'b00 && m_ocp.m_resp_accept && state == RD_ACTIVE) begin
        mem_read_data <= m_ocp.s_data;
      end
    end
  end
  
endmodule
