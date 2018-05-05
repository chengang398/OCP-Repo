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
  
endinterface
