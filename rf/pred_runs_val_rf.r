source("l0_pred_fn_val_rf.r")
args = commandArgs(trailingOnly=TRUE)

# Parse arguments:
# Arg 1: the outer fold index
# Arg 2: [--demo], flag for whether demo run or not
outer_fold <- args[1]
demo_mode <- "--demo" %in% args

i <- 1
j <- 1
k <- outer_fold
print(paste("k", k))
print(paste("demo_mode", demo_mode))

# Pass demo flag to model function
output <- pred_val_rf(i, j, k, demo=demo_mode)

# Set output format based on mode (aligned with original code)
if (demo_mode) {
  fname <- paste("rf_pred_val_run", k, ".RData", sep="")
} else {
  fname <- paste("rf_pred_val_run", k, ".r", sep="")
}

save(output, file=fname)
