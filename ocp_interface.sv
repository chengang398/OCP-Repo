// ocp is a open centric protocol which defines performance bus freelance interface
// between IP cores that reduces design time, style risk and production cost of SoC.
// import ocp_pkg::*;
package ocp_pkg;
  
  parameter int M_CMD_IDLE = 3'b000; // idle / nop (none) 
  parameter int M_CMD_WR   = 3'b001; // write 
  parameter int M_CMD_RD   = 3'b010; // read 
  parameter int M_CMD_RDEX = 3'b011; // read ex
  parameter int M_CMD_RDL  = 3'b100; // read linked
  parameter int M_CMD_WRNP = 3'b101; // write non post
  parameter int M_CMD_WRC  = 3'b110; // write conditional
  parameter int M_CMD_BCST = 3'b111; // write broadcast
  
  parameter int S_RESP_NULL = 2'b00; // No response NULL 
  parameter int S_RESP_DVA  = 2'b01; // Data valid / accept DVA 
  parameter int S_RESP_FAIL = 2'b10; // Request failed FAIL 
  parameter int S_RESP_ERR  = 2'b11; // Response error ERR
  
  parameter int M_BURST_SEQ_INCR  = 3'b000; // Incrementing INCR
  parameter int M_BURST_SEQ_DFLT1 = 3'b001; // Custom (packed) DFLT1
  parameter int M_BURST_SEQ_WRAP  = 3'b010; // Wrapping WRAP
  parameter int M_BURST_SEQ_DFLT2 = 3'b011; // Custom (not packed) DFLT2
  parameter int M_BURST_SEQ_XOR   = 3'b100; // Exclusive OR XOR
  parameter int M_BURST_SEQ_STRM  = 3'b101; // Streaming STRM
  parameter int M_BURST_SEQ_UNKN  = 3'b110; // Unknown UNKN
  parameter int M_BURST_SEQ_BLCK  = 3'b111; // 2-dimensional Block BLCK
  
endpackage

interface ocp_if #(
  parameter int TAGI_WIDTH = 5,
  parameter int INFO_WIDTH = 4,
  parameter int BLEN_WIDTH = 4,
  parameter int DATA_WIDTH = 32,
  parameter int ADDR_WIDTH = 5
);
  
  logic [ADDR_WIDTH-1:0]   m_addr;
  logic [BLEN_WIDTH-1:0]   m_burst_lenght;
  logic [2:0]              m_burst_seq; // INCR = 3'b000
  logic [DATA_WIDTH/8-1:0] m_byteen;
  logic [2:0]              m_cmd;
  logic [DATA_WIDTH-1:0]   m_data;
  logic [DATA_WIDTH/8-1:0] m_data_byteen;
  logic                    m_data_last;
  logic [TAGI_WIDTH-1:0]   m_data_tagid;
  logic                    m_data_valid;
  logic [INFO_WIDTH-1:0]   m_req_info;
  logic                    m_resp_accept;
  logic [TAGI_WIDTH-1:0]   m_tagid;
  logic                    s_cmd_accept;
  logic [DATA_WIDTH-1:0]   s_data;
  logic                    s_data_accept;
  logic [1:0]              s_resp; // DVA = 2'b01
  logic                    s_resp_last;
  logic [TAGI_WIDTH-1:0]   s_tagid;
  
  modport master (
    output m_addr,
    output m_burst_length,
    output m_burst_seq, // INCR = 3'b000
    output m_byteen,
    output m_cmd,
    output m_data,
    output m_data_byteen,
    output m_data_last,
    output m_data_tagid,
    output m_data_valid,
    output m_req_info,
    output m_resp_accept,
    output m_tagid,
    input  s_cmd_accept,
    input  s_data,
    input  s_data_accept,
    input  s_resp, // DVA = 2'b01
    input  s_resp_last,
    input  s_tagid
  );
  
  modport slave (
    input  m_addr,
    input  m_burst_length,
    input  m_burst_seq, // INCR = 3'b000
    input  m_byteen,
    input  m_cmd,
    input  m_data,
    input  m_data_byteen,
    input  m_data_last,
    input  m_data_tagid,
    input  m_data_valid,
    input  m_req_info,
    input  m_resp_accept,
    input  m_tagid,
    output s_cmd_accept,
    output s_data,
    output s_data_accept,
    output s_resp, // DVA = 2'b01
    output s_resp_last,
    output s_tagid
  );
  
endinterface
