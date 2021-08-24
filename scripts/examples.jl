import Pkg; Pkg.add("DataRegistryUtils")
Pkg.add("CSV")
Pkg.add("DataFrames")
Pkg.add("Random")
import DataRegistryUtils
import CSV
import DataFrames
import Random

parent_dir = "working-configs"
dirs = filter(x -> isdir(joinpath(parent_dir, x)), readdir(parent_dir, join = true))

## 1. Empty code run
wc = readdir(dirs[1], join = true)[2]
handle = DataRegistryUtils.initialise(wc)
DataRegistryUtils.finalise(handle; comments="Empty code run example.")

## 4. Write data product (csv)
wc = readdir(dirs[2], join = true)[2]
handle = DataRegistryUtils.initialise(wc)
# println(typeof(handle.config["write"][1]["use"]["public"]))
# println(typeof(handle.config["write"][1]["use"]["public2"]))
tmp = CSV.read("examples/register/tbl.csv", DataFrames.DataFrame)
DataRegistryUtils.write_table(handle, tmp, "test/csv")
DataRegistryUtils.finalise(handle; comments="Write CSV example.")
