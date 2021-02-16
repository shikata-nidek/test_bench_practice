import glob
from os.path import join, dirname
from vunit import VUnitCLI
from vunit.verilog import VUnit

cli = VUnitCLI()
cli.parser.add_argument(
    '--unit',
    metavar='unit_name',
    required=True,
    help='(Required) test terget name (i.e. \'L00_Template\')'
)

args = cli.parse_args()
vu = VUnit.from_args(args=args)

target_path = dirname(__file__)+"./"+args.unit+"/"
src_path = join(target_path, "src/")
tb_path = join(target_path, "tb/")

lib = vu.add_library("lib")
lib.add_source_files(join(src_path, "*.sv"), allow_empty=True)
lib.add_source_files(join(src_path, "*.v"))
lib.add_source_files(join(tb_path, "*.sv"))
lib.add_source_files(join(tb_path, "*.v"), allow_empty=True)

#vu.set_sim_option("modelsim.vsim_flags.gui", ["-msgmode both", "-displaymsgmode both"])

vu.main()
