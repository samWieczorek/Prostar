library(shiny)
library(highcharter)
library(MSnbase)



source(file.path("../server", "mod_plots_tracking.R"), local=TRUE)$value
source(file.path("../server","mod_plots_intensity.R"), local=TRUE)$value



ui <- fluidPage(
  checkboxInput('sync', 'sync Slave with Master', value=FALSE),
  mod_plots_tracking_ui('master_tracking'),
  mod_plots_intensity_ui('plots_boxplots')
)



server <- function(input, output, session) {
  
  utils::data(Exp1_R25_prot, package='DAPARdata')
  obj <- Exp1_R25_prot
  keyId <- obj@experimentData@other$proteinId
  
  r <- reactiveValues(
    settings = NULL,
    master = NULL
  )
  
  
  #metadata <- metadata(Exp1_R25_prot)
  conds <- pData(obj)$Condition
   fData(obj) <- cbind(fData(obj), ProtOfInterest=rep(0,nrow(obj)))
  fData(obj)$ProtOfInterest[10:20] <- 1
  
  r$master <- callModule(mod_plots_tracking_server,'master_tracking', 
                         obj = reactive({obj}),
                         keyId=reactive({keyId}),
                         params=reactive({NULL}),
                         reset=reactive({FALSE}),
                         slave = reactive({FALSE})
  )
  
  callModule(mod_plots_intensity_server,'plots_boxplots', 
             dataIn = reactive({obj}),
             meta = reactive({fData(obj)}),
             keyId = reactive({keyId}),
             conds = reactive({conds}),
             pal = reactive({NULL}),
             params = reactive({if(input$sync) 
               r$master() else NULL
             }),
             reset = reactive({FALSE}),
             slave = reactive({input$sync})
             
  )
  
}


shinyApp(ui, server)