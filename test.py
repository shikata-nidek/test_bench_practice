import glob
from os.path import join, dirname
from vunit import VUnitCLI
from vunit.verilog import VUnit

def get_filelist_in_subdir (path):
    return glob.glob(path, recursive=True)

def post_run(results):
    results.merge_coverage(file_name="coverage_data.ucdb")

cli = VUnitCLI()
cli.parser.add_argument(
       '--unit',
       metavar='unit_name',
       required=True,
       help='(Required) test target name (i.e. \'L08_chattering\')')
cli.parser.add_argument(
    '--coverage',
    action='store_true',
    help='obtain code-coverage (Default: false)'
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

vu.set_sim_option("modelsim.vsim_flags.gui", ["-msgmode both", "-displaymsgmode both"])
if not args.coverage:
    vu.main()
else:
    vu.set_compile_option("modelsim.vlog_flags", ["+cover=sbcef"])
    vu.set_compile_option("enable_coverage", True)
    vu.set_sim_option("enable_coverage", True)
    vu.set_sim_option(
        "modelsim.vsim_flags", 
        ["-do \"coverage exclude -srcfile vunit_pkg.sv -srcfile tb_topmodule.sv\""]
    )
    vu.main(post_run=post_run)
