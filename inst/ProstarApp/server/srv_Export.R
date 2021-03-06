
callModule(moduleStaticDataTable,"viewProcessingData", table2show=reactive({BuildParamDataProcessingDT()}), showRownames=FALSE,
           filename='processingData')

callModule(moduleStaticDataTable,"viewDataMining",  table2show=reactive({BuildParamDataMiningDT()}), showRownames=FALSE,
           filename='datamining_view')

callModule(moduleStaticDataTable,"viewProstarVersions", table2show=reactive({getPackagesVersions()[-3,]}), showRownames=FALSE,
           filename='Prostar_Versions')



output$plotsFor_Original_protein <- renderTree({list("Descr stats"= ll_descrStats)})

output$plotsFor_Original_peptide <- renderTree({list( "Descr stats"= ll_descrStats )})

output$plotsFor_Filtered_protein <- renderTree({ list("Descr stats"= ll_descrStats)})

output$plotsFor_Filtered_peptide <- renderTree({list( "Descr stats"= ll_descrStats)})

output$plotsFor_Normalized_protein <- renderTree({list("Descr stats"= ll_descrStats,"compNorm"="compNorm")})

output$plotsFor_Normalized_peptide <- renderTree({ list( "Descr stats"= ll_descrStats,"compNorm"="compNorm")})

output$plotsFor_Imputed_protein <- renderTree({ list("Descr stats"= ll_descrStats)})

output$plotsFor_Imputed_peptide <- renderTree({list( "Descr stats"= ll_descrStats)})

output$plotsFor_HypothesisTest_protein <- renderTree({ list("Descr stats"= ll_descrStats, "logFCDistr" ="logFCDistr" )})

output$plotsFor_HypothesisTest_peptide <- renderTree({list( "Descr stats"= ll_descrStats, "logFCDistr" ="logFCDistr" )})

output$plotsFor_Aggregated_protein <- renderTree({ list("Descr stats"= ll_descrStats)})
output$plotsFor_Aggregated_peptide <- renderTree({list( "Descr stats"= ll_descrStats)})




shinyTree_GetSelected <- reactive({
  tmp <- unlist(shinyTree::get_selected(input$plotsFor_Original_peptide, format = "names"))
  tmp
})


# observeEvent(input$plotsFor_Original_peptide, {
#   tmp <- unlist(shinyTree::get_selected(input$plotsFor_Original_peptide, format = "names"))
#   for (i in 1:length(ll)){
#     print(ll[[i]][1])
#   }
#   })


output$choosedataToExportMSnset <- renderUI({
  req(rv$dataset)
  
  dnames <- unlist(lapply(names(rv$dataset), function(x){unlist(strsplit(x, " - "))[[1]]}))
  .choices <- names(rv$dataset)
  names(.choices) <- dnames
  radioButtons("chooseDatasetToExportToMSnset", 
               "Choose which dataset to export",
               choices = c("None"="None",.choices))
  
})



observeEvent(rv$dataset, {
  
  for (i in 1:length(names(rv$dataset))){
    txt <-paste0('treeFor.',names(rv$dataset)[i])
    txt <- gsub(".", "_", txt, fixed=TRUE)
    #print(paste0("toggle : ", txt))
    shinyjs::toggle(txt)
   }
 
})





GetDatasetShortNames <- reactive({
  req(rv$dataset)
  
  dnames <- unlist(lapply(names(rv$dataset), function(x){unlist(strsplit(x, ".", fixed=TRUE))[[1]]}))
  dnames
})



output$exportOptions <- renderUI({
  req(input$chooseDatasetToExportToMSnset)
  if (input$chooseDatasetToExportToMSnset == "None"){return(NULL)}
  
  tagList(
    fluidRow(
      column(width=2, modulePopoverUI("modulePopover_exportFileFormat")),
      column(width=10, selectInput("fileformatExport", "",choices=  gFileFormatExport))
    ),
    
    # br(),
    # fluidRow(
    #   column(width=2,modulePopoverUI("modulePopover_exportMetaData")),
    #   column(width=10,uiOutput("chooseMetaDataExport",width = widthWellPanel))
    # ),
    br(),
    fluidRow(
      column(width=2, modulePopoverUI("modulePopover_exportFilename")),
      column(width=10, uiOutput("chooseExportFilename"))
    ),
    
    br(),
    downloadButton('downloadMSnSet', 'Download')
  )
})






# 
# output$chooseMetaDataExport <- renderUI({
#   req(rv$current.obj)
#   
#   
#   choices <- setdiff(colnames(fData(rv$current.obj)), rv$current.obj@experimentData@other$names_metacell)
#   names(choices) <- choices
#   
#   selectizeInput("colsToExport",
#                  label = "",
#                  choices = choices,
#                   multiple = TRUE, width='500px')
#   
# })



callModule(modulePopover,"modulePopover_exportMetaData", 
           data = reactive(list(title = "Metadata", 
                                content="Select the columns you want to keep as metadata. By default, if any column is specified, all metadata in your dataset will be exported.")))

callModule(modulePopover,"modulePopover_exportFileFormat", 
           data = reactive(list(title = "File format", 
                                content="File format")))



callModule(modulePopover,"modulePopover_exportFilename", 
           data = reactive(list(title = "Filename", 
                                content="Enter the name of the files to be created")))




output$chooseExportFilename <- renderUI({
  
  textInput("nameExport", label = "", value = rv$current.obj.name)
})




output$downloadMSnSet <- downloadHandler(
  #input$chooseDatasetToExportToMSnset,
  filename = function() { 
    #input$nameExport
    if (input$fileformatExport == gFileFormatExport$excel) {
      paste(input$nameExport,gFileExtension$excel,  sep="")}
    else if (input$fileformatExport == gFileFormatExport$msnset)
    {
      paste(input$nameExport,gFileExtension$msnset,  sep="")}
    else if (input$fileformatExport == gFileFormatExport$zip)
    {
      paste(input$nameExport,gFileExtension$zip,  sep="")}
    
  },
  content = function(file) {
     dataToExport <- rv$dataset[[input$chooseDatasetToExportToMSnset]]
    # addColumns <- c(input$colsToExport, rv$current.obj@experimentData@other$names_metacell)
    # res <- Get_AllComparisons(dataToExport)
    # print(str(res))
    # if (!is.null(res)){
    #   addColumns <- c(addColumns, colnames(res))
    # }
    # Biobase::fData(dataToExport) <- select(Biobase::fData(dataToExport),c(rv$proteinId, addColumns))
    # 
    
    colnames(fData(dataToExport)) <- gsub(".", "_", colnames(fData(dataToExport)), fixed=TRUE)
    names(dataToExport@experimentData@other) <- gsub(".", "_", names(dataToExport@experimentData@other), fixed=TRUE)
    
    dataToExport@experimentData@other$Prostar_Version = installed.packages(lib.loc = Prostar.loc)["Prostar","Version"]
    dataToExport@experimentData@other$DAPAR_Version = installed.packages(lib.loc = DAPAR.loc)["DAPAR","Version"]
    dataToExport@experimentData@other$proteinId = gsub(".", "_", rv$proteinId, fixed=TRUE)
    
    if (input$fileformatExport == gFileFormatExport$excel) {
      fname <- paste(input$nameExport,gFileExtension$excel,  sep="")
      print(fname)
      writeMSnsetToExcel(dataToExport, input$nameExport)
      file.copy(fname, file)
      file.remove(fname)
    }
    
    else if  (input$fileformatExport == gFileFormatExport$msnset) {
      fname <- paste(input$nameExport,gFileExtension$msnset,  sep="")
      saveRDS(dataToExport, file=fname)
      file.copy(fname, file)
      file.remove(fname)
    }
    
    else if  (input$fileformatExport == gFileFormatExport$zip) {
      fname <- paste(input$nameExport,gFileExtension$zip,  sep="")
      writeMSnsetToCSV(dataToExport,fname)
      file.copy(fname, file)
      file.remove(fname)
    }
  }
)





output$choosedataTobuildReport <- renderUI({
  rv$dataset
  if (is.null(rv$dataset)){return (NULL)}
  
  checkboxGroupInput("chooseDatasetToExport", 
                     "Datasets to export",
                     choices = names(rv$dataset),
                     selected = names(rv$dataset))
  
})


# 
# output$downloadProcessingData <- downloadHandler(
#   
#   filename = function() { 
#     paste0('summary_', input$datasets,'.pdf')
#   },
#   content = function(file) {
#     out <- rmarkdown::render('Rmd_sources/report.Rmd', 
#                       output_file = rv$outfile,
#                       rmarkdown::pdf_document())
#   }
# )
#     


######-----------------------------------------------------------------
output$downloadReport <- downloadHandler(
  input$reportFilename,
  filename = function() {
    paste0(input$reportFilename, sep = '.pdf')
  },
  
  content = function(file) {
    toto()
    filename <- rv$outfile
    #print(filename)
    require(rmarkdown)
    #paramRmd <- list(current.obj=rv$current.obj)
    out <- rmarkdown::render(rv$outfile, 
                             output_file = file,
                             pdf_document()
    ) # END render
    
    #file.rename(out, file)
  }
)


BuildParamDataProcessingDT <- reactive({
  req(rv$current.obj)
  req(input$datasets)
  tmp.params <- rv$current.obj@experimentData@other$Params
  #ind <- which(input$datasets == names(tmp.params))
  df <- data.frame(Dataset = names(tmp.params),
                   Process = rep("",length(names(tmp.params))),
                   Parameters = rep("",length(names(tmp.params))),
                   stringsAsFactors = FALSE)
  
  for (iData in 1:length(names(tmp.params))) {
    p <- tmp.params[[iData]]
    processName <- ifelse(is.null(names(tmp.params[[iData]])), "-",names(tmp.params[[iData]]))
    # if (processName=='Imputation'){
    #   processName <- paste0(processName,rv$typeOfData)
    # }
    df[iData, "Process"] <- processName
    if (length(tmp.params[[iData]][[processName]])==0){
      df[iData,"Parameters"]<- '-'
    } else {
      

      df[iData,"Parameters"]<- do.call(paste0("getTextFor",processName), 
                                       list(l.params=tmp.params[[iData]][[processName]]))
    }
  }
  
  df
})



BuildParamDataMiningDT <- reactive({
  req(rv$current.obj)
  
  nbLines <- sum((as.character(input$selectComparison) != "None"), !is.null(rv$params.GO))
  if (nbLines ==0) {
    df <- NULL
  } else {
    df <- data.frame(Dataset = rep(input$datasets,length(names(nbLines))),
                     Process = rep("",length(names(nbLines))),
                     Parameters = rep("",length(names(nbLines))),
                     stringsAsFactors = FALSE)
    
    if (!is.null(as.character(input$selectComparison))){
      df[1,"Dataset"]<- input$datasets
      df[1,"Process"]<- "Differential analysis"
      #ll <- setNames(split(rv$widgets$anaDiff[,2], seq(nrow(rv$widgets$anaDiff))), rv$widgets$anaDiff[,1])
      df[1,"Parameters"]<- getTextForAnaDiff(rv$widgets$anaDiff)
    } else {}
    
  }
  df
})

