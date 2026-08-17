source("l0_pred_fn_val_gamb_ind.r")
args = commandArgs(trailingOnly=TRUE)

# Parse arguments:
# Arg 1: the outer fold index
# Arg 2: the inner fold index
# Arg 3: [--demo], flag for whether demo run or not
i <- 1
j <- args[1]
k <- args[2]
demo_mode <- "--demo" %in% args

print(paste("j", j))
print(paste("k", k))
print(paste("demo_mode", demo_mode))

# Call the model function
output <- pred_val_gamb(i, j, k, demo=demo_mode)

fname <- paste("gamb_pred_val_run", j, "_", k, ".RData", sep="")
save(output, file=fname)
