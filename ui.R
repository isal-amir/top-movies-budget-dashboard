dashboardPage(
  skin = "blue",
  ##-- Header 
  dashboardHeader(
    title = "Top Movies Based on Movie Budget Analysis",
    titleWidth = 350
  ),
  
  ##-- Sidebar
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "page1", icon = icon("book")), # tabName yang nanti buat manggil 
      menuItem("Genre Analysis", tabName = "page2", icon = icon("moon")),
      menuItem("Dataset", tabName = "page3", icon = icon("server")),
      menuItem("About Code & Developer", tabName = "page4", icon = icon("github"))
    )
  ),
  
  ##--Dashboard
  dashboardBody(
    tabItems(
      # --- PAGE 1 ---
      tabItem(
        tabName = "page1",
        # --- ROW 1: Info Box
        fluidRow(
          infoBox(width=3,
                  color = "purple",
                  title = "Total Movies",
                  icon=icon("film"),
                  value = nrow(movies)),
          infoBox(width=3,
                  color = "purple",
                  title = "Genre",
                  icon=icon("laptop"),
                  value = length(unique(movies$genre))),
          infoBox(width=3,
                  color = "purple",
                  title = "Range Year",
                  icon=icon("calendar"),
                  value = "1991-2022"),
          infoBox(width=3,
                  color = "purple",
                  title = "Cost Production",
                  icon=icon("money"),
                  value = "US$ 91M - 400M")
          ),
        
        # --- ROW 2: plot1
        fluidRow(
          box(width = 6,
              plotlyOutput(outputId = "plot1")
          ),
          box(width = 6,
              plotlyOutput(outputId = "plot2")
          )
        ),
        
        # --- ROW 3: plot3 (scatter)
        fluidRow(
          box(width = 12,
              plotlyOutput(outputId = "plot3")
          )
        )),
      # --- PAGE 2 ---
      tabItem(
        tabName = "page2",
        # --- ROW 1: boxplot genre vs crr (all time)
          fluidRow(
            box(width = 12,
                plotlyOutput(outputId = "plot4")
            )
          ),
          
          # --- ROW 2: input box slider tahun
          fluidRow(
            box(width = 12,
                sliderInput(inputId = "input_tahun",
                            label = "Select Year",
                            min = 1991,
                            max = 2022,
                            value = 2022,
                            sep = ""))
            
          ),
          
          # --- ROW 3: boxplot genre vs crr per tahun
          fluidRow(
            box(width = 12,
                plotlyOutput(outputId = "plot5")
            )
          ),
          
          # --- ROW 4: input box pilihan genre
          fluidRow(
            box(width = 12,
                selectInput(inputId = "input_genre",
                            label = "Select Genre",
                            choices = unique(movies$genre),
                            selected = "Action"))
          ),
          
          # --- ROW 5: top 10 movies berdasar cost, top 10 movies berdasar profit
          fluidRow(
            box(width = 6,
                plotlyOutput(outputId = "plot6")
            ),
            box(width = 6,
                plotlyOutput(outputId = "plot7")
            )
          )
        ),
        
      # --- PAGE 3 ---
      tabItem(
        tabName = "page3",
        # --- ROW 1: Info Box
        fluidRow(width = 12,
                 title = "Data of Top Movies Based on Production Cost",
                 dataTableOutput(outputId = "dataset_table"))
      ),
      
      # -- PAGE 4
      tabItem(
        tabName = "page4",
        fluidRow(
          infoBox(width = 12,
              title = "About Code",
              icon = icon("github"),
              tags$h1("Github Repository"),
              tags$div(
                "If you are interested to develop this web further, ",
                tags$a(href="https://github.com/isal-amir/top-500-movie", 
                       "click here to go to the repo of this work")
              ))
        ),
        fluidRow(
          box(width = 12,
              title = "About Developer",
              #tags$h1("Github Link"),
              icon = icon("linkedIn"),
              tags$div(
                "You can find information about the developer and his projects through the platforms below"
              ))
        ),
        fluidRow(
          infoBox(width=4,
                  color = "purple",
                  title = "LinkedIn",
                  icon=icon("linkedin"),
                  tags$div(tags$a(href="https://linkedin.com/in/faisalamirmaz", 
                                  "click here"))),
          infoBox(width=4,
                  color = "purple",
                  title = "Github",
                  icon=icon("github"),
                  tags$div(tags$a(href="https://github.com/isal-amir/",
                                 "click here"))),
          infoBox(width=4,
                  color = "purple",
                  title = "rpubs",
                  icon=icon("chain"),
                  tags$div(tags$a(href="https://rpubs.com/isal_amir",
                                 "click here")))
      )
      )
)
)
)
