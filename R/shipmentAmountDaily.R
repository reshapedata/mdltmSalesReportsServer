#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#' @param erp_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' shipmentAmountDailyReportServer()
shipmentAmountDailyReportServer <- function(input,output,session,dms_token,erp_token) {
  text_date_shipmentAmountDaily_select = tsui::var_date('text_date_shipmentAmountDaily_select')


  shiny::observeEvent(input$btn_shipmentAmountDaily_view,{
    FDate=text_date_shipmentAmountDaily_select()
    print(FDate)

    data = mdltmSalesReportsPkg::shipmentAmountDaily_view(erp_token =erp_token ,FDate =FDate )

    tsui::run_dataTable2(id ='shipmentAmountDaily_resultView' ,data =data )

    FYearMonth =  substr(FDate, start = 1, stop = 7)
    filename = paste0('每日发货金额报表',FYearMonth,'.xlsx')

    tsui::run_download_xlsx(id = 'dl_shipmentAmountDaily',data = data,filename = filename)

  })

}


#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#' @param erp_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' shipmentAmountDailyPriceServer()
shipmentAmountDailyPriceServer <- function(input,output,session,dms_token,erp_token) {
  text_flie_shipmentAmountDaily_price = tsui::var_file('text_flie_shipmentAmountDaily_price')


  shiny::observeEvent(input$btn_shipmentAmountDaily_Up,{
    if(is.null(text_flie_shipmentAmountDaily_price())){

      tsui::pop_notice('请选择要上传的文件')
    }
    else{
      filename=text_flie_shipmentAmountDaily_price()
      data <- readxl::read_excel(filename,
                                 col_types = c("text", "text", "numeric"))


      data = as.data.frame(data)

      data = tsdo::na_standard(data)


      tsda::db_writeTable2(token  = erp_token,table_name = 'rds_t_MaterialPrice_input',r_object = data,append = TRUE)

      mdltmSalesReportsPkg::shipmentAmountDaily_delete(erp_token = erp_token)
      mdltmSalesReportsPkg::shipmentAmountDaily_insert(erp_token =erp_token )
      mdltmSalesReportsPkg::shipmentAmountDaily_truncate(erp_token = erp_token)

      tsui::pop_notice('上传成功')



    }

  })

  shiny::observeEvent(input$btn_shipmentAmountDaily_price_view,{
    data = mdltmSalesReportsPkg::shipmentAmountDaily_price_view(erp_token = erp_token)

    tsui::run_dataTable2(id ='shipmentAmountDaily_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_shipmentAmountDaily_price',data = data,filename = '单价维护表.xlsx')



  })
  shiny::observeEvent(input$btn_shipmentAmountDaily_select,{
    data = mdltmSalesReportsPkg::shipmentAmountDaily_select(erp_token = erp_token)

    tsui::run_dataTable2(id ='shipmentAmountDaily_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_shipmentAmountDaily_reportPrice',data = data,filename = '每日发货金额单价为0数据.xlsx')



  })





}



#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param erp_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' shipmentAmountDailyServer()
shipmentAmountDailyServer <- function(input,output,session,dms_token,erp_token) {
  shipmentAmountDailyPriceServer(input = input,output = output,session=session,dms_token= dms_token,erp_token=erp_token)
  shipmentAmountDailyReportServer(input = input,output = output,session=session,dms_token= dms_token,erp_token=erp_token)
}









