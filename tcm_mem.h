#ifndef _SCGENMOD_tcm_mem_
#define _SCGENMOD_tcm_mem_

#include "systemc.h"

class tcm_mem : public sc_foreign_module
{
public:
    sc_in<bool> clk_i;
    sc_in<bool> rst_i;
    sc_in<bool> mem_i_rd_i;
    sc_in<bool> mem_i_flush_i;
    sc_in<bool> mem_i_invalidate_i;
    sc_in<sc_uint<32> > mem_i_pc_i;
    sc_in<sc_uint<32> > mem_d_addr_i;
    sc_in<sc_uint<32> > mem_d_data_wr_i;
    sc_in<bool> mem_d_rd_i;
    sc_in<sc_uint<4> > mem_d_wr_i;
    sc_in<bool> mem_d_cacheable_i;
    sc_in<sc_uint<11> > mem_d_req_tag_i;
    sc_in<bool> mem_d_invalidate_i;
    sc_in<bool> mem_d_writeback_i;
    sc_in<bool> mem_d_flush_i;
    sc_in<bool> axi_awvalid_i;
    sc_in<sc_uint<32> > axi_awaddr_i;
    sc_in<sc_uint<4> > axi_awid_i;
    sc_in<sc_uint<8> > axi_awlen_i;
    sc_in<sc_uint<2> > axi_awburst_i;
    sc_in<bool> axi_wvalid_i;
    sc_in<sc_uint<32> > axi_wdata_i;
    sc_in<sc_uint<4> > axi_wstrb_i;
    sc_in<bool> axi_wlast_i;
    sc_in<bool> axi_bready_i;
    sc_in<bool> axi_arvalid_i;
    sc_in<sc_uint<32> > axi_araddr_i;
    sc_in<sc_uint<4> > axi_arid_i;
    sc_in<sc_uint<8> > axi_arlen_i;
    sc_in<sc_uint<2> > axi_arburst_i;
    sc_in<bool> axi_rready_i;
    sc_out<bool> mem_i_accept_o;
    sc_out<bool> mem_i_valid_o;
    sc_out<bool> mem_i_error_o;
    sc_out<sc_uint<32> > mem_i_inst_o;
    sc_out<sc_uint<32> > mem_d_data_rd_o;
    sc_out<bool> mem_d_accept_o;
    sc_out<bool> mem_d_ack_o;
    sc_out<bool> mem_d_error_o;
    sc_out<sc_uint<11> > mem_d_resp_tag_o;
    sc_out<bool> axi_awready_o;
    sc_out<bool> axi_wready_o;
    sc_out<bool> axi_bvalid_o;
    sc_out<sc_uint<2> > axi_bresp_o;
    sc_out<sc_uint<4> > axi_bid_o;
    sc_out<bool> axi_arready_o;
    sc_out<bool> axi_rvalid_o;
    sc_out<sc_uint<32> > axi_rdata_o;
    sc_out<sc_uint<2> > axi_rresp_o;
    sc_out<sc_uint<4> > axi_rid_o;
    sc_out<bool> axi_rlast_o;


    tcm_mem(sc_module_name nm, const char* hdl_name)
     : sc_foreign_module(nm),
       clk_i("clk_i"),
       rst_i("rst_i"),
       mem_i_rd_i("mem_i_rd_i"),
       mem_i_flush_i("mem_i_flush_i"),
       mem_i_invalidate_i("mem_i_invalidate_i"),
       mem_i_pc_i("mem_i_pc_i"),
       mem_d_addr_i("mem_d_addr_i"),
       mem_d_data_wr_i("mem_d_data_wr_i"),
       mem_d_rd_i("mem_d_rd_i"),
       mem_d_wr_i("mem_d_wr_i"),
       mem_d_cacheable_i("mem_d_cacheable_i"),
       mem_d_req_tag_i("mem_d_req_tag_i"),
       mem_d_invalidate_i("mem_d_invalidate_i"),
       mem_d_writeback_i("mem_d_writeback_i"),
       mem_d_flush_i("mem_d_flush_i"),
       axi_awvalid_i("axi_awvalid_i"),
       axi_awaddr_i("axi_awaddr_i"),
       axi_awid_i("axi_awid_i"),
       axi_awlen_i("axi_awlen_i"),
       axi_awburst_i("axi_awburst_i"),
       axi_wvalid_i("axi_wvalid_i"),
       axi_wdata_i("axi_wdata_i"),
       axi_wstrb_i("axi_wstrb_i"),
       axi_wlast_i("axi_wlast_i"),
       axi_bready_i("axi_bready_i"),
       axi_arvalid_i("axi_arvalid_i"),
       axi_araddr_i("axi_araddr_i"),
       axi_arid_i("axi_arid_i"),
       axi_arlen_i("axi_arlen_i"),
       axi_arburst_i("axi_arburst_i"),
       axi_rready_i("axi_rready_i"),
       mem_i_accept_o("mem_i_accept_o"),
       mem_i_valid_o("mem_i_valid_o"),
       mem_i_error_o("mem_i_error_o"),
       mem_i_inst_o("mem_i_inst_o"),
       mem_d_data_rd_o("mem_d_data_rd_o"),
       mem_d_accept_o("mem_d_accept_o"),
       mem_d_ack_o("mem_d_ack_o"),
       mem_d_error_o("mem_d_error_o"),
       mem_d_resp_tag_o("mem_d_resp_tag_o"),
       axi_awready_o("axi_awready_o"),
       axi_wready_o("axi_wready_o"),
       axi_bvalid_o("axi_bvalid_o"),
       axi_bresp_o("axi_bresp_o"),
       axi_bid_o("axi_bid_o"),
       axi_arready_o("axi_arready_o"),
       axi_rvalid_o("axi_rvalid_o"),
       axi_rdata_o("axi_rdata_o"),
       axi_rresp_o("axi_rresp_o"),
       axi_rid_o("axi_rid_o"),
       axi_rlast_o("axi_rlast_o")
    {
        elaborate_foreign_module(hdl_name);
    }
    ~tcm_mem()
    {}

};

#endif

