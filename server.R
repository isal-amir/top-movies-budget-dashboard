shinyServer(function(input, output) {
  output$plot1 <- renderPlotly({
    top10_cost <- movies %>% 
      head(10) %>% 
      mutate(
        label= glue(
          "Production Cost: US$ {comma(production_cost/1000000)}M
      Genre: {genre}
      Production Year: {year}")
      )
    plot1 <- ggplot(data=top10_cost, aes(x = production_cost,
                                         y = reorder(title, production_cost),
                                         text = label)) +
      geom_col(aes(fill = production_cost))+
      scale_fill_gradient(low="pink", high = "coral")+
      labs(title="10 Movies with The Biggest Production Cost",
           x = "Production Cost (US$)",
           y = NULL)+
      scale_x_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
      scale_y_discrete(labels = scales::wrap_format(20))+
      theme_minimal()+
      theme_gray(base_size = 10)+
      theme(plot.title = element_text(size = 11, face = "bold"))+
      theme(legend.position = "none")
      #theme(plot.title = element_text(hjust = 1)) 
    ggplotly(plot1, tooltip="text")
  })
  
  output$plot2 <- renderPlotly({
    top10_profit <- movies %>% 
      arrange(-profit) %>% 
      head(10) %>% 
      mutate(
        label= glue(
          "Profit: US$ {comma(profit/1000000)}M
      Genre: {genre}
      Production Year: {year}")
      )
    plot2 <- ggplot(data=top10_profit, aes(x = profit,
                                           y = reorder(title, profit),
                                           text = label)) +
      geom_col(aes(fill = profit))+
      scale_fill_gradient(low="pink", high = "purple")+
      labs(title="10 Movies with The Biggest Profit",
           x = "Profit (US$)",
           y = NULL)+
      scale_x_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
      scale_y_discrete(labels = scales::wrap_format(20))+
      theme_minimal()+
      theme_gray(base_size = 10)+
      theme(plot.title = element_text(size = 11, face = "bold"))+
      theme(legend.position = "none")
    ggplotly(plot2, tooltip = "text")
  })
  
  output$plot3 <- renderPlotly({
    movies <- movies %>% 
      mutate(scatter_text = glue(
        "Title: {title}
    Production Cost: US$ {comma(production_cost/1000000)}M
    Profit: US$ {comma(round(profit/1000000,1))}M"
      ))
    
    plot3 <- ggplot(movies, aes( x= production_cost, y=profit, text = scatter_text))+
      geom_point(aes(col = crr))+
      scale_color_gradient(low="coral", high="darkorchid4")+
      scale_x_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
      scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
      
      theme_minimal()+
      labs(title="Scatterplot-Relationship Between Production Cost and Profit",
           x = "Production Cost (US$)",
           y = "Profit (US$)")+
      theme(legend.position = "none")
    ggplotly(plot3, tooltip = "text")
  })
  
  output$plot4 <- renderPlotly({
    plot4 <- ggplot(movies, aes(x=genre, y=crr))+
      geom_boxplot(fill="coral")+
      #geom_jitter()+
      coord_flip()+
      labs(title="Cost Revenue Relationship (CRR) on Every Genre",
           subtitle = "CRR = cost/revenue x 100%",
           y = "CRR (%)",
           x = ""
      )
    ggplotly(plot4) %>% 
      layout(title = list(text = paste0(
        'Cost Revenue Relationship (CRR) on Every Genre',
        '<br>',
        '<sup>',
        'CRR = Production Cost/Revenue x 100% (smaller better)',
        '</sup>'
      )))
  })
  
  
  output$plot5 <- renderPlotly({
    coba <- select_year(movies, input$input_tahun)
    plot5 <- ggplot(coba, aes(x=genre, y=crr))+
      geom_boxplot( fill = "pink")+
      coord_flip()+
      labs(title="Cost Revenue Relationship (CRR) on Year {}",
           subtitle = "CRR = cost/revenue x 100%",
           y = "CRR (%)",
           x = ""
      )
    ggplotly(plot5)%>% 
      layout(title = list(text = paste0(
        glue('Cost Revenue Relationship (CRR) on Year {input$input_tahun}'),
        '<br>',
        '<sup>',
        'CRR = Production Cost/Revenue x 100% (smaller better)',
        '</sup>'
      )))
  })
  
  output$plot6 <- renderPlotly({
    pil_10_cost <- movies %>% 
      select_genre(input$input_genre) %>% # bisa gini ternyata
      head(10) %>% 
      mutate(label = glue(
        "Production Cost: US$ {comma(production_cost/1000000)}M
    Year: {year}"
      ))
    
    plot6 <- ggplot(data=pil_10_cost, aes(x = production_cost,
                                          y = reorder(title, production_cost),
                                          text = label)) +
      geom_col(aes(fill = production_cost))+
      scale_fill_gradient(low="pink", high = "coral")+
      labs(title=str_wrap(glue("10 Movies with The Biggest Production Cost in Genre: {input$input_genre}"), 40),
           x = "Production Cost (US$)",
           y = NULL)+
      scale_x_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
      scale_y_discrete(labels = scales::wrap_format(20))+
      theme_minimal()+
      theme_gray(base_size = 10)+
      theme(plot.title = element_text(size = 11, face = "bold"))+
      #theme(plot.title = element_text(hjust = 1))+
      
      theme(legend.position = "none")
    ggplotly(plot6, tooltip = "text")
  })
  
  output$plot7 <- renderPlotly({
    pil_10_profit <- movies %>% 
      select_genre(input$input_genre) %>% # bisa gini ternyata
      arrange(-profit) %>% 
      head(10) %>% 
      mutate(label = glue(
        "Profit: US$ {comma(profit/1000000)}M
    Production Year: {year}"
      ))
    
    
    plot7 <- ggplot(data=pil_10_profit, aes(x = profit,
                                            y = reorder(title, profit),
                                            text = label)) +
      geom_col(aes(fill = profit))+
      scale_fill_gradient(low="pink", high = "purple")+
      labs(title=str_wrap(glue("10 Movies with The Biggest Profit in Genre: {input$input_genre}"), 40),
           x = "Profit (US$)",
           y = NULL)+
      scale_x_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
      scale_y_discrete(labels = scales::wrap_format(20))+
      theme_minimal()+
      theme_gray(base_size = 10)+
      theme(plot.title = element_text(size = 11, face = "bold"))+
      #theme(plot.title = element_text(size = 11))+
      #theme_gray(base_size = 10)+
      theme(legend.position = "none")
    ggplotly(plot7, tooltip = "text")
  })
  
  output$dataset_table <- renderDataTable(movies,
                                          options = list(scrollX = T,
                                                         scrollY = T))
})
