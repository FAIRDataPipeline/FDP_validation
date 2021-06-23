library(rFDP)

# Open the connection to the local registry with a given config file
handle <- initialise()

df <- data.frame(a = 1:2, b = 3:4)
rownames(df) <- 1:2

write_array(array = as.matrix(df),
            handle = handle,
            data_product = "test/array",
            component = "component1/a/s/d/f/s",
            description = "Some description",
            dimension_names = list(rowvalue = rownames(df),
                                   colvalue = colnames(df)),
            dimension_values = list(NA, 10),
            dimension_units = list(NA, "km"),
            units = "s")

finalise(handle)
