shinyServer(function(input, output) {

  volcano <- eventReactive(input$simulate, {

    # plotdata <- reactive({
    #   ifelse(is.null(input$upload),diffres,data.table::fread(input$upload$datapath))
    # })
    if(is.null(input$upload)==T){
      plot_volcano(data = diffres,
                   cutoff_logFC = input$cutoff_logFC,
                   cutoff_pvalue = input$cutoff_pvalue,
                   cutoff_fdr = input$cutoff_fdr,
                   use_p = input$use_p,
                   color_up = input$color_up,
                   color_down = input$color_down,
                   color_unsig = input$color_unsig,
                   plot_alpha = input$plot_alpha,
                   plot_size = input$plot_size,
                   plot_xlab = input$plot_xlab,
                   plot_ylab = input$plot_ylab,
                   plot_title = input$plot_title,
                   plot_xlim = input$plot_xlim,
                   plot_ylim = input$plot_ylim,
                   plot_theme = input$plot_theme,
                   show_gnum = input$show_gnum
      )
    }else{
      plotdata <- reactive({data.table::fread(input$upload$datapath)})
      plot_volcano(data = plotdata(),
                   cutoff_logFC = input$cutoff_logFC,
                   cutoff_pvalue = input$cutoff_pvalue,
                   cutoff_fdr = input$cutoff_fdr,
                   use_p = input$use_p,
                   color_up = input$color_up,
                   color_down = input$color_down,
                   color_unsig = input$color_unsig,
                   plot_alpha = input$plot_alpha,
                   plot_size = input$plot_size,
                   plot_xlab = input$plot_xlab,
                   plot_ylab = input$plot_ylab,
                   plot_title = input$plot_title,
                   plot_xlim = input$plot_xlim,
                   plot_ylim = input$plot_ylim,
                   plot_theme = input$plot_theme,
                   show_gnum = input$show_gnum
      )
    }

  })

  output$plot <- renderPlot({ volcano() }, res = 96)

  output$download_png <- downloadHandler(
    filename = function() {
      "Volcano.png"
    },
    content = function(file) {
      ggplot2::ggsave(plot = volcano(),filename =  file,dpi = 300)
    }
  )

  output$download_pdf <- downloadHandler(
    filename = function() {
      "Volcano.pdf"
    },
    content = function(file) {
      ggplot2::ggsave(plot = volcano(),filename =  file,dpi = 300)
    }
  )
}
)
