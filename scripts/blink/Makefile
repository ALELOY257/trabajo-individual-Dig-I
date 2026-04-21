ICE40_SIM_CELLS=$(shell yosys-config --datdir/ecp5/cells_sim.v)

TARGET=blink


TCL_SCRIPT = auto_generated.tcl

COMM_OBJS =  ${TARGET}.v

OBJS += $(COMM_OBJS)

BUILD_DIR = build

all: sim

sim:
	rm -f a.out *.vcd
	iverilog -DBENCH  ${TARGET}_TB.v $(OBJS)
	vvp a.out
	gtkwave ${TARGET}_TB.vcd

sim_verilator: 
	verilator -CFLAGS '-I../libfemtorv32/ -DSTANDALONE_FEMTOELF' -DBENCH -DBOARD_FREQ=10 -DCPU_FREQ=10 -DPASSTHROUGH_PLL -Wno-fatal \
	--top-module SOC -cc -exe sim_main.cpp libfemtorv32/femto_elf.c soc_femto.v
	cd obj_dir; make -f VSOC.mk 
	obj_dir/VSOC

svg: $(OBJS)
	rm -rf *svg *out *dot
	yosys -p "prep -top ${TARGET}; memory_map; opt; opt_expr; techmap; abc -g AND,OR,XOR; write_json ${TARGET}.json" ${OBJS}
	yosys -p "read_verilog ${TARGET}.v; proc; memory_map; opt; opt_expr; techmap; abc -g AND,OR,XOR; show -format dot -prefix ${TARGET}_out"
	netlistsvg ${TARGET}.json -o ${TARGET}.svg
	google-chrome ${TARGET}.svg


configure: ${TARGET}.fs
	sudo openFPGALoader -b tangprimer20k -m impl/pnr/project.fs
########################
#  LATTICE COLORLIGHT 5A
########################
$(TARGET)_out.config: $(TARGET).json
	nextpnr-ecp5 --json $(BUILD_DIR)/$< --lpf $(TARGET).lpf --textcfg $(BUILD_DIR)/$@ --25k --package CABGA256 --speed 6  --timing-allow-fail --seed 1 --lpf-allow-unconstrained  --log $(TARGET)_pnr.log 
#	nextpnr-ecp5 --json $< --lpf $(TARGET).lpf --textcfg $@ --25k --package CABGA381 --speed 6  --timing-allow-fail --seed 1 --lpf-allow-unconstrained
$(TARGET).json: $(OBJS)
	mkdir -p $(BUILD_DIR)
#	yosys -p 'verilog_defaults -push; verilog_defaults -add -defer; read_verilog -formal $(OBJS); verilog_defaults -pop; attrmap -tocase keep -imap keep="true" keep=1 -imap keep="false" keep=1 -remove keep=0; synth_ecp5 -top $(TARGET); write_json $(BUILD_DIR)/$@' -l $(BUILD_DIR)/${TARGET}.rpt
	yosys -v3 -l synth.log -p 'attrmap -tocase keep -imap keep="true" keep=1  ; synth_ecp5 -top $(TARGET);  write_json  $(BUILD_DIR)/$@' ${OBJS} -l $(BUILD_DIR)/${TARGET}.rpt

$(TARGET).bit: $(TARGET)_out.config
	ecppack --bootaddr 0 --compress $(BUILD_DIR)/$< --svf $(BUILD_DIR)/${TARGET}.svf --bit $(BUILD_DIR)/$@

configure_lattice: ${TARGET}.bit   # TDI:TDO:TCK:TMS TXD:CTS:DTR:RXD
#	sudo openFPGALoader -c ft232RL --pins=0:3:4:1 -m $(BUILD_DIR)/${TARGET}.bit 	
#	sudo openFPGALoader -c ft232RL --pins=RXD:RTS:TXD:CTS -m $(BUILD_DIR)/${TARGET}.bit 	
	sudo openFPGALoader -c ft232RL --pins=TXD:CTS:DTR:RXD -m $(BUILD_DIR)/${TARGET}.bit	