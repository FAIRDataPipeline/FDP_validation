library(rFDP)

# Open the connection to the local registry with a given config file
handle <- initialise()

data_product <- "test/array"
component <- "level/a/s/d/f/s"

read_array(handle = handle,
           data_product = data_product,
           component = component)

finalise(handle)
