# shiny app to display drug metabolite measurements in wastewater in Europe
# data source is the EMCDDA and SCORE project, see
# https://www.emcdda.europa.eu/publications/html/pods/waste-water-analysis_en#sourceData

ggplot2::theme_set(ggplot2::theme_bw())

ww_weekdays <- c('Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday', 'Monday', 'Tuesday')
utils::globalVariables(c('ww_data', 'ww_col', 'ww_cities', 'City'))

#' Display Wastewater Measurements
#'
#' @return NULL
#' @export
#' @importFrom rlang .data
#' @importFrom dplyr %>%
ww <- function() {

  # Define UI for application that draws a histogram
  ui <- shiny::fluidPage(
      shiny::plotOutput('plot'),
      shiny::selectInput('city_selected', 'Cities', ww_cities, multiple = TRUE, selected = sample(ww_cities,1)),
      'Based on',
      shiny::tags$a(href='https://www.emcdda.europa.eu/publications/html/pods/waste-water-analysis_en#sourceData',
                    'EMCDDA and SCORE data')
  )

  # Define server logic required to draw a histogram
  server <- function(input, output) {
      output$plot <- shiny::renderPlot({
        shiny::req(input$city_selected)
        ww_data %>%
          dplyr::filter(.data$City %in% input$city_selected) %>%
          ggplot2::ggplot(ggplot2::aes(x=.data$weekday, y=.data$value, group=.data$Year, color=.data$Year)) +
          ggplot2::scale_colour_manual(values = ww_col) +
          ggplot2::xlab(NULL) + ggplot2::ylab('mg/day/1000 inhabitants') +
          ggplot2::guides(colour = ggplot2::guide_legend(reverse=TRUE)) +
          ggplot2::ggtitle('Drug Metabolites in Wastewater across one Week') +
          ggplot2::geom_point() + ggplot2::geom_line() +
          ggplot2::facet_grid(rows=ggplot2::vars(.data$Metabolite), cols=ggplot2::vars(factor(City, levels = input$city_selected)), scales='free_y')
      })
  }

  # Run the application
  shiny::shinyApp(ui = ui, server = server)
}
