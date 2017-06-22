package Memory;

import RegFile 				:: *;
import TLM2	 				:: *;
import FIFOF				:: *;
import SpecialFIFOs			:: *;
import DefaultValue 		:: *;
import TLMReqRsp			:: *;
import Utils 				:: *;

`include "defined_parameters.bsv"
`include "TLM2Defs.defines"

interface Memory_IFC;
	interface TLMRecvIFC #(Req_Mem, Rsp_Mem) bus_rd_ifc;
	interface TLMRecvIFC #(Req_Mem, Rsp_Mem) bus_wr_ifc;
endinterface

module mkMemory #(String name) (Memory_IFC);

FIFOF #(Req_Mem) ff_rd_reqs <- mkBypassFIFOF;
FIFOF #(Rsp_Mem) ff_rd_rsps <- mkBypassFIFOF;

FIFOF #(Req_Mem) ff_wr_reqs <- mkBypassFIFOF;
FIFOF #(Rsp_Mem) ff_wr_rsps <- mkBypassFIFOF;

RegFile #(UInt#(`DCACHE_SIZE), Bit#(TMul #(`Word_size, 8))) memory <- mkRegFileFullLoad ("code.mem");

rule rl_process_rd_requests;
	
	Req_Mem request = ff_rd_reqs.first; ff_rd_reqs.deq;
    
	Bit #(`DCACHE_SIZE) cache_address = 0;

	Rsp_Mem rsp = defaultValue;

	if (request matches tagged Descriptor .r) begin
    	cache_address = zeroExtend((r.addr >> 3)[23:0]);
		rsp.transaction_id = r.transaction_id;
		rsp.command = r.command;
		
		if (r.command == READ) begin
			Bit #(`DCACHE_SIZE) tmp_data = ?;
			rsp.data[63:0] = memory.sub(unpack(cache_address));
			//case (r.burst_size)
			//	0: if (addr_aligned) rsp.data = {56'b0, tmp_data[7:0]};
			//	1: if (addr_aligned) rsp.data = {48'b0, tmp_data[15:0]};
			//	2: if (addr_aligned) rsp.data = {40'b0, tmp_data[23:0]};
			//	3: if (addr_aligned) rsp.data = {32'b0, tmp_data[31:0]}; else rsp.data = {32'b0, tmp_data[63:32]};
			//	4: if (addr_aligned) rsp.data = {24'b0, tmp_data[39:0]};
			//	5: if (addr_aligned) rsp.data = {16'b0, tmp_data[47:0]};
			//	6: if (addr_aligned) rsp.data = {8'b0,  tmp_data[55:0]};
			//	7: if (addr_aligned) rsp.data = tmp_data[63:0];
			//endcase
			rsp.status = SUCCESS;
			$display($time, " %s: READ Requested: Addr: %h with data %h", name, r.addr, rsp.data[63:0]);
		end
	end
	ff_rd_rsps.enq (rsp);

endrule

rule rl_process_wr_requests;
  	
	Req_Mem request = ff_wr_reqs.first; 
    Bit#(`DCACHE_SIZE) cache_address = 0;
	Rsp_Mem rsp = defaultValue;

	if (request matches tagged Descriptor .r) begin
    	cache_address = r.addr >> 3;
		rsp.transaction_id = r.transaction_id;
		rsp.command = r.command;
		if (r.command == WRITE) begin
			memory.upd(unpack(cache_address), r.data[63:0]);
			$display($time, " %s: WRITE (Descriptor) Requested: Addr: %h, Data: %h", name, r.addr, r.data);
			ff_wr_reqs.deq;
		end
	end

	ff_wr_rsps.enq (rsp);
endrule

interface bus_rd_ifc = toRecvIFC (ff_rd_reqs, ff_rd_rsps);
interface bus_wr_ifc = toRecvIFC (ff_wr_reqs, ff_wr_rsps);

endmodule

endpackage
