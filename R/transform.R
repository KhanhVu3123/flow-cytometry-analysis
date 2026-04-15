transform_flowtrans <- function(flow_frame, method) {
  res <- flowTrans(
    dat = flow_frame,
    fun = method,
    dims = colnames(exprs(flow_frame)),
    n2f = FALSE,
    parameters.only = FALSE
  )
  data.frame(exprs(res$result))
}

run_transformations <- function(flow_data) {
  flow_frame <- flowFrame(as.matrix(flow_data))
  
  biexp <- biexponentialTransform("biexp")
  flowTrans_biexp <- flowCore::transform(
    flow_frame,
    transformList(colnames(flow_data), biexp)
  )
  
  list(
    flowTrans_arcsinh = transform_flowtrans(flow_frame, "mclMultivArcSinh"),
    flowTrans_boxcox  = transform_flowtrans(flow_frame, "mclMultivBoxCox"),
    flowTrans_linlog  = transform_flowtrans(flow_frame, "mclMultivLinLog"),
    flowTrans_biexp   = data.frame(exprs(flowTrans_biexp)),
    arcsinh_co1       = asinh(flow_data),
    arcsinh_co150     = asinh(flow_data / 150)
  )
}