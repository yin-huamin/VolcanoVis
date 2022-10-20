plot_volcano<-function(data,
                       cutoff_logFC = 1, cutoff_pvalue = 0.05, cutoff_fdr = 1,
                       use_p = TRUE,
                       color_up = "red", color_down = "blue", color_unsig = "grey",
                       plot_alpha = 0.5, plot_size = 2,
                       plot_xlab = "log2 (Fold Change)", plot_ylab = "-log10 (Pvalue)", plot_title = "",
                       plot_xlim = c(-8,8), plot_ylim = c(0,12),
                       plot_theme = "classic",
                       show_gnum = 5,...
){
  # @ param data : A data.frame, with column1 : gene, column2 : logFC, columne3 : pvalue, column4 : fdr
  # @ param cutoff_logFC : A numeric, log2(fold change) value cutoff
  # @ param cutoff_fdr : A numeric, log2(fold change) value cutoff
  # @ param use_p : A logical, use p or fdr for y lab, default TURE, use pvalue
  # @ param color_up : A character, Up-regulated gene colors
  # @ param color_down : A character, Down-regulated gene colors
  # @ param unsig : A character, Nonesig gene colors
  # @ param plot_alpha : A numeric between 0 ~ 1, transparent of points
  # @ param plot_size : A numeric, size of points
  # @ param plot_xlab : A character, text for xlabs
  # @ param plot_ylab : A character, text for ylabs
  # @ param plot_title : A character, text for titles
  # @ param plot_xlim : A numeric vector, xlab limits, default is c(-8,8)
  # @ param plot_ylim : A numeric vector, ylab limits, default is c(-6,8)
  # @ param plot_theme : A charatcer, theme of the points, default is classic
  # @ param show_gene : A logical, if show the most significant genes, default is TURE
  # @ param show_gnum : A numeric, the number of most significant genes, default is 5
  # ...
  # @ output : A Volcano plot ploted by ggplot2

  # 1. process data ----
  colnames(data)[1:4] <- c("gene","logFC","PValue","FDR")

  diffres <- data %>%
    dplyr::mutate(type = case_when(logFC>=cutoff_logFC & PValue <= cutoff_pvalue & FDR <= cutoff_fdr ~ "Up",
                                   logFC< (-cutoff_logFC) & PValue <= cutoff_pvalue & FDR <= cutoff_fdr ~ "Down",
                                   TRUE ~ "UnSig")
           )


  # 2. visualize ----

  plot_vline = c(-cutoff_logFC,cutoff_logFC)
  plot_hline = -log10(cutoff_pvalue)

  plot_theme <- switch(plot_theme,
                       "classic" = theme_classic(),
                       "bw" = theme_bw(),
                       "dark" = theme_dark(),
                       "line_draw" = theme_linedraw(),
                       "minimal" = theme_minimal(),
                       "prism" = theme_prism()
  )


  if(use_p==T){
    P<-diffres %>%
      ggplot(aes(logFC,-log10(PValue),colour=type))+
      geom_point(alpha=plot_alpha, size=plot_size) +
      # color
      scale_color_manual(values=c("Down"=color_down,
                                  "Up"=color_up,
                                  "UnSig"=color_unsig))+
      # x,y cutoff line
      geom_vline(xintercept= plot_vline,lty=4,col="black",lwd=0.8) +
      geom_hline(yintercept = plot_hline,lty=4,col="black",lwd=0.8) +
      # x,ylabs and title
      labs(x=plot_xlab,
           y=plot_ylab)+
      ggtitle(plot_title)+
      # axis limit
      coord_cartesian(xlim = plot_xlim,ylim = plot_ylim)+
      # theme
      plot_theme+

      theme(plot.title = element_text(hjust = 0.5),
            legend.position="right",
            legend.title = element_blank(),
            legend.text = element_text(size=12)
      )
  }else{
    P<-diffres %>%
      ggplot(aes(logFC,-log10(FDR),colour=type))+
      geom_point(alpha=plot_alpha, size=plot_size) +
      # color
      scale_color_manual(values=c("Down"=color_down,
                                  "Up"=color_up,
                                  "UnSig"=color_unsig))+
      # x,y cutoff line
      geom_vline(xintercept= plot_vline,lty=4,col="black",lwd=0.8) +
      geom_hline(yintercept = plot_hline,lty=4,col="black",lwd=0.8) +
      # x,ylabs and title
      labs(x=plot_xlab,
           y=plot_ylab)+
      ggtitle(plot_title)+
      # axis limit
      coord_cartesian(xlim = plot_xlim,ylim = plot_ylim)+
      # theme
      plot_theme+

      theme(plot.title = element_text(hjust = 0.5),
            legend.position="right",
            legend.title = element_blank(),
            legend.text = element_text(size=12))
  }


  if(show_gnum>0){

    diff.sig<-diffres |>
      dplyr::filter(!str_detect(type,"UnSig")) |>
      arrange(PValue) |>
      group_by(type) |>
      dplyr::filter(row_number()< show_gnum+2)

    P<-P+geom_text_repel(data = diff.sig,
                         mapping = aes(x=logFC,v=-log10(PValue),label=gene),
                         size = 3,
                         force = 3,
                         key_glyph="point")
  }


  return(P)

}
