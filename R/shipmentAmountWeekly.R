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
#' shipmentAmountWeeklyReportServer()
shipmentAmountWeeklyReportServer <- function(input,output,session,dms_token,erp_token) {
  text_numeric_shipmentAmountWeekly_select = tsui::var_numeric('text_numeric_shipmentAmountWeekly_select')


  shiny::observeEvent(input$btn_shipmentAmountWeekly_view,{
    FDate=text_numeric_shipmentAmountWeekly_select()
    print(FDate)


    if(FDate==0||is.null(FDate)){
      tsui::pop_notice('请输入要查询的年份')

    }
    else{


    }




    data = mdltmSalesReportsPkg::shipmentAmountWeekly_view(erp_token =erp_token ,FDate =FDate )

    tsui::run_dataTable2(id ='shipmentAmountWeekly_resultView' ,data =data )

    filename = paste0('月销售额报表',FDate,'.xlsx')
    # print(filename)
    tsui::run_download_xlsx(id = 'dl_shipmentAmountWeekly_report',data = data,filename = filename)})

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
#' shipmentAmountWeeklyServer()
shipmentAmountWeeklyServer <- function(input,output,session,dms_token,erp_token) {

  shipmentAmountWeeklyReportServer(input = input,output = output,session=session,dms_token= dms_token,erp_token=erp_token)
}









