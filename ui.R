shinyUI(
  fluidPage(

    titlePanel(title = "VolcanoVis", windowTitle = "Volcano Plot With Differential Analysis"),

    sidebarLayout(
      sidebarPanel(
        width = 2,
        actionButton("simulate", "Plot",class = "btn-block"),

        sliderInput("cutoff_logFC", "Select LogFC Cutoff:", min = 0.1, max = 10, value = 1),
        sliderInput("cutoff_pvalue", "Select PValue Cutoff:", min = 0, max = 1, value = 0.05),
        sliderInput("cutoff_fdr", "Select FDR(BH) Cutoff:", min = 0, max = 1, value = 1),

        checkboxInput("use_p", "PValue for Y axis ?", value = TRUE),

        sliderInput("plot_alpha", "Select Transparent Level:", min = 0, max = 1, value = 0.5),
        sliderInput("plot_size", "Select Point Size:", min = 0.5, max = 10, value = 2),

        sliderInput("plot_xlim", "X axis Range:", value = c(-8, 8), min = -20, max = 20),
        sliderInput("plot_ylim", "Y axis Range:", value = c(0,12), min = -1, max = 20),

        sliderInput("show_gnum", "Show Most Signicant Gene Numbers:", value = 5, min = 0, max = 20),

        textInput("color_up", "Color Of Up-Regulated Genes:",value = "red"),
        textInput("color_down", "Color Of Down-Regulated Genes:", value = "blue"),
        textInput("color_unsig", "Color Of Normal Genes:",value = "grey"),

        textInput("plot_xlab", "X title:",value = "log2 (Fold Change)"),
        textInput("plot_ylab", "Y title:",value = "-log10 (PValue)"),
        textInput("plot_title", "Title:",value = ""),

        selectInput("plot_theme", "Plot Theme:", theme_list)
      ),
      mainPanel(
        fluidRow(
          column(9,
                 plotOutput("plot",height = 600,width = 800)),
          column(2,
                 fileInput("upload", NULL, buttonLabel = "Upload...", accept = c(".csv", ".tsv", ".txt")),
                 br(),br(),
                 downloadButton("download_png","Download:PNG"),
                 br(),br(),
                 downloadButton("download_pdf","Download:PDF"))
        )


      )
    )

  )

)
