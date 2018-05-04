// ocp is a open centric protocol which defines performance bus freelance interface
// between IP cores that reduces design time, style risk and production cost of SoC.
interface ocp_if #(
  parameter int TAGI_WIDTH = 5,
  parameter int BLEN_WIDTH = 4,
  parameter int DATA_WIDTH = 32,
  parameter int ADDR_WIDTH = 5
);
  
  logic [ADDR_WIDTH-1:0]   maddr;
  logic [BLEN_WIDTH-1:0]   mburstlenght;
  logic [2:0]              mburstseq; // INCR = 3'b000
  logic [DATA_WIDTH/8-1:0] mbyteen;
  logic [2:0]              mcmd;
  
endinterface
