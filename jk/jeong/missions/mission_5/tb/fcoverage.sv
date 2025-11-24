class fcoverage;
	transaction cov_trx;
	mailbox #(transaction) cov_mbox;

	event gen_done;
	event cov_done;

	covergroup tr_cg with function sample(transaction tr);
		rw_cvpt : coverpoint tr.is_write{
			bins READ = {0};
			bins WRITE = {1};
		}
		addr_cvpt: coverpoint tr.addr {
			bins LOW = {['h00 : 'h3F]};
			bins MID_LOW = {['h40 : 'h7F]};
			bins MID_HIGH = {['h80 : 'hBF]};
			bins HIGH = {['hc0 : 'hFF]};
		}
		data_cvpt: coverpoint tr.data { option.auto_bin_max = 3; }
		cr_cc : cross addr_cvpt, rw_cvpt; 
	endgroup
	function new();
		tr_cg = new();
	endfunction
	task run();
		$display("[%10t] [cov] run() is started...", $time);
		wait (gen_done.triggered);
		forever begin
			cov_trx = new();
			cov_mbox.get(cov_trx);
			tr_cg.sample(cov_trx);
			cov_trx.print("COV");
			if(!cov_mbox.try_peek(cov_trx)) break;
		end
	$display("[%10t] [COV] all monitored transaction coverage check is done...", $time);
	-> cov_done;
	endtask
endclass
