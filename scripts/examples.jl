import Pkg; Pkg.add("DataPipeline")
Pkg.add("CSV")
Pkg.add("DataFrames")
Pkg.add("Random")
import DataPipeline
import CSV
import DataFrames
import Random

parent_dir = "working-configs"
dirs = readdir(parent_dir, join = true)

println(dirs)

## 1. Empty code run
wc = readdir(dirs[1], join = true)[2]
handle = DataPipeline.initialise(wc)
DataPipeline.finalise(handle; comments="Empty code run example.")

## 4. Write data product (csv)
wc = readdir(dirs[2], join = true)[2]
handle = DataPipeline.initialise(wc)
# println(typeof(handle.config["write"][1]["use"]["public"]))
# println(typeof(handle.config["write"][1]["use"]["public2"]))
tmp = CSV.read("examples/register/tbl.csv", DataFrames.DataFrame)
DataPipeline.write_table(handle, tmp, "test/csv")
DataPipeline.finalise(handle; comments="Write CSV example.")
