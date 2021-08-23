####  Simple examples for new FAIR version of the DP  ####
# This implements:
# https://fairdatapipeline.github.io/docs/interface/example0/
# Steps:                                                    Code:
# 0. preliminaries                                          L24
# 1. Empty code run                                         L32
# 2. Write data product (Array)                             L43
# 3. Read data product (Array)                              L65
# 4. Write data product (Tables.jl)                         L103
# 5. Read data product (Tables.jl)                          L107
# 6. Write data product (point estimate)                    L111
# 7. Read data product (point estimate)                     L133
# 8. Write data product (distribution)                      L111
# 9. Read data product (distribution)                       L133
# 10. Issues - TBA
#
# Author:   Martin Burke (martin.burke@bioss.ac.uk)
# Date:     20-Jul-2021
#### #### #### #### ####

## LOCAL DR INSTRUCTIONS:
# - start using: ~/.scrc/scripts/run_scrc_server
# - stop using: ~/.scrc/scripts/stop_scrc_server
# - view tcp using: sudo netstat -ntap | grep LISTEN
import DataRegistryUtils
import CSV
import DataFrames
import Random

## 1. Empty code run
wc = "examples/simple2/working_config1.yaml"
handle = DataRegistryUtils.initialise(wc)
DataRegistryUtils.finalise(handle; comments="Empty code run example.")

## 2. Write data product (HDF5)
# NB. you need to update the version number in
# the config file when registering *new* data
# (hint: that includes HDF5 files with a different timestamp)
wc = "examples/simple2/working_config2.yaml"
handle = DataRegistryUtils.initialise(wc)
Random.seed!(0)
tmp = reshape(rand(10), 2, :)       # create an array
DataRegistryUtils.write_array(handle, tmp, "test/array", "component1/a/s/d/f/s")
DataRegistryUtils.finalise(handle; comments="Write HDF5 example.")

## 3. Read data product (HDF5)
wc = "examples/simple2/working_config3.yaml"
handle = DataRegistryUtils.initialise(wc)
tmp = DataRegistryUtils.read_array(handle, "test/array", "component1/a/s/d/f/s")
println("ARRAY: ", tmp)
DataRegistryUtils.finalise(handle; comments="Read HDF5 example.")

## 4. Write data product (csv)
wc = "examples/simple2/working_config4.yaml"
handle = DataRegistryUtils.initialise(wc)
# println(typeof(handle.config["write"][1]["use"]["public"]))
# println(typeof(handle.config["write"][1]["use"]["public2"]))
tmp = CSV.read("examples/register/tbl.csv", DataFrames.DataFrame)
DataRegistryUtils.write_table(handle, tmp, "test/csv")
DataRegistryUtils.finalise(handle; comments="Write CSV example.")

## 5. Read data product (csv)
wc = "examples/simple2/working_config5.yaml"
handle = DataRegistryUtils.initialise(wc)
tmp = DataRegistryUtils.read_table(handle, "test/csv")
println("TABLE: ", DataFrames.first(tmp, 3))
DataRegistryUtils.finalise(handle; comments="Read CSV example.")

## 6. Write data product (point estimate)
wc = "examples/simple2/working_config6.yaml"
handle = DataRegistryUtils.initialise(wc)
DataRegistryUtils.write_estimate(handle, 222822951599, "test/estimate/asymptomatic-period", "asymptomatic-period")
DataRegistryUtils.finalise(handle; comments="Write point estimate example.")

## 7. Read data product (point estimate)
wc = "examples/simple2/working_config7.yaml"
handle = DataRegistryUtils.initialise(wc)
tmp = DataRegistryUtils.read_estimate(handle, "test/estimate/asymptomatic-period", "asymptomatic-period")
println("nb. read estimate := ", tmp)
DataRegistryUtils.finalise(handle; comments="Read point estimate example.")

## 8. Write data product (distribution)
wc = "examples/simple2/working_config8.yaml"
handle = DataRegistryUtils.initialise(wc)
DataRegistryUtils.write_distribution(handle, "Gaussian", Dict("mean" => -16.08, "SD" => 30), "test/distribution/symptom-delay", "symptom-delay")
DataRegistryUtils.finalise(handle; comments="Write distribution example.")

## 9. Read data product (distribution)
wc = "examples/simple2/working_config9.yaml"
handle = DataRegistryUtils.initialise(wc)
tmp = DataRegistryUtils.read_distribution(handle, "test/distribution/symptom-delay", "symptom-delay")
println("nb. read distribution := ", tmp)
DataRegistryUtils.finalise(handle; comments="Read distribution example.")

## 10. Register issues
# wc = "examples/simple2/working_config10.yaml"
# handle = DataRegistryUtils.initialise(wc)
# - component
# DataRegistryUtils.raise_issue(handle, "", "Some issue with a component.")
# - data product
# DataRegistryUtils.raise_issue(handle, "", "Some issue with a data product.")
# - config
# config_url = ""
# - ss
# - GitHub repo (object)
# - external object

## TBA: Delete
# - data product
# - code run
