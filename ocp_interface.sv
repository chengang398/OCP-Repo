// ocp is a open centric protocol which defines performance bus freelance interface
// between IP cores that reduces design time, style risk and production cost of SoC.
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
