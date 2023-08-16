#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(readr)
library(tidyr)

dat <- readr::read_csv('../rawdata/ww-data-long-2023-05-02.csv')
cities <- unique(sort(dat$City))
w <- c('Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday', 'Monday', 'Tuesday')


# Define UI for application that draws a histogram
ui <- fluidPage(
    plotOutput('plot'),
    selectInput('city_selected', 'Cities', cities, multiple = TRUE, selected = cities[1]),
    'Based on EMCDDA and SCORE data from https://www.emcdda.europa.eu/publications/html/pods/waste-water-analysis_en#sourceData'
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$plot <- renderPlot({
      dat %>%
        dplyr::filter(City %in% input$city_selected) %>%
        dplyr::group_by(City, Metabolite, Year) %>%
        tidyr::pivot_longer(cols = dplyr::all_of(w)) %>%
        dplyr::mutate(name = factor(name, levels = w, ordered = TRUE)) %>%
        ggplot2::ggplot(ggplot2::aes(x=name, y=value, group=Year, color=Year)) +
        ggplot2::scale_color_continuous(trans='reverse') +
        ggplot2::xlab(NULL) + ggplot2::ylab('mg/day/1000 inhabitants') +
        ggplot2::guides(colour = ggplot2::guide_legend(reverse=TRUE)) +
        ggplot2::ggtitle('Drug Metabolites in Wastewater across one Week') +
        ggplot2::geom_point() + ggplot2::geom_line() +
        ggplot2::facet_grid(rows=ggplot2::vars(Metabolite), cols=ggplot2::vars(City), scales='free_y') +
        ggplot2::theme_bw()
    })
}

# Run the application
shinyApp(ui = ui, server = server)
