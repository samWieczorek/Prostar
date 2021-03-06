tabPanel("Export",
         value = "ExportTab",
         tabsetPanel(
           id = "Export_tabSetPanel",
           # tabPanel("Process summary",
           #          tagList(
           #            moduleStaticDataTableUI("viewProstarVersions"),
           #          br(),br(),br(),
           #          downloadButton('downloadProcessingData', 'Download', class=actionBtnClass),
           #          moduleStaticDataTableUI("viewProcessingData")
           #          )
           #          ),
           tabPanel("Export to file",
                    value = "export",
                    helpText("Export customization tab"),
                    
                    uiOutput("choosedataToExportMSnset"),
                    hr(),
                    uiOutput("exportOptions")
           ),
           
           tabPanel("Build report (Beta)",
                    tagList(
                      moduleStaticDataTableUI("viewProstarVersions"),
                      downloadButton('downloadReport', "Build and download pdf report", class = actionBtnClass),
                      
                      tags$hr(),
                      tags$div(
                        tags$div( style="display:inline-block; vertical-align: top;",
                                  moduleStaticDataTableUI("viewProcessingData")
                        ),
                        tags$div( style="display:inline-block; vertical-align: top;",
                                  shinyBS::bsCollapse(id = "collapseDataProcessingExport", open = "",
                                                      shinyBS::bsCollapsePanel("Plots for data processing tools", 
                                                             tags$div(
                                                               tags$div( style="display:inline-block; vertical-align: top;",
                                                                         hidden(tags$div(id='treeFor_Original_protein',
                                                                                         tagList(
                                                                                           tags$p(tags$b("Original protein")),
                                                                                           shinyTree::shinyTree("plotsFor_Original_protein",theme="proton", themeIcons = FALSE, themeDots = FALSE, checkbox = TRUE)
                                                                                         )
                                                                         )
                                                                         )
                                                               ),
                                                               tags$div( style="display:inline-block; vertical-align: top;",
                                                                         hidden(tags$div(id='treeFor_Original_peptide',
                                                                                         tagList(
                                                                                           tags$p(tags$b("Original peptide")),
                                                                                           shinyTree::shinyTree("plotsFor_Original_peptide",theme="proton", themeIcons = FALSE, themeDots = FALSE, checkbox = TRUE)
                                                                                         )
                                                                         )
                                                                         )
                                                               ),
                                                               
                                                               tags$div( style="display:inline-block; vertical-align: top;",
                                                                         hidden(tags$div(id='treeFor_Filtered_protein',
                                                                                         tagList(
                                                                                           tags$p(tags$b("Filtered protein")),
                                                                                           shinyTree::shinyTree("plotsFor_Filtered_protein",theme="proton", themeIcons = FALSE, themeDots = FALSE, checkbox = TRUE)
                                                                                         )
                                                                         )
                                                                         )
                                                               ),
                                                               
                                                               tags$div( style="display:inline-block; vertical-align: top;",
                                                                         hidden(tags$div(id='treeFor_Filtered_peptide',
                                                                                         tagList(
                                                                                           tags$p(tags$b("Filtered peptide")),
                                                                                           shinyTree::shinyTree("plotsFor_Filtered_peptide",theme="proton", themeIcons = FALSE, themeDots = FALSE, checkbox = TRUE)
                                                                                         )
                                                                         )
                                                                         )
                                                               ),
                                                               
                                                               tags$div( style="display:inline-block; vertical-align: top;",
                                                                         hidden(tags$div(id='treeFor_Normalized_protein',
                                                                                         tagList(
                                                                                           tags$p(tags$b("Normalized protein")),
                                                                                           shinyTree::shinyTree("plotsFor_Normalized_protein",theme="proton", themeIcons = FALSE, themeDots = FALSE, checkbox = TRUE)
                                                                                         )
                                                                         )
                                                                         )
                                                               ),
                                                               
                                                               tags$div( style="display:inline-block; vertical-align: top;",
                                                                         hidden(tags$div(id='treeFor_Normalized_peptide',
                                                                                         tagList(
                                                                                           tags$p(tags$b("Normalized peptide")),
                                                                                           shinyTree::shinyTree("plotsFor_Normalized_peptide",theme="proton", themeIcons = FALSE, themeDots = FALSE, checkbox = TRUE)
                                                                                         )
                                                                         )
                                                                         )
                                                               ),
                                                               
                                                               tags$div( style="display:inline-block; vertical-align: top;",
                                                                         hidden(tags$div(id='treeFor_Aggregated_protein',
                                                                                         tagList(
                                                                                           tags$p(tags$b("Aggregated protein")),
                                                                                           shinyTree::shinyTree("plotsFor_Aggregated_protein",theme="proton", themeIcons = FALSE, themeDots = FALSE, checkbox = TRUE)
                                                                                         )
                                                                         )
                                                                         )
                                                               ),
                                                               
                                                               
                                                               tags$div( style="display:inline-block; vertical-align: top;",
                                                                         hidden(tags$div(id='treeFor_Aggregated_peptide',
                                                                                         tagList(
                                                                                           tags$p(tags$b("Aggregated peptide")),
                                                                                           shinyTree::shinyTree("plotsFor_Aggregated_peptide",theme="proton", themeIcons = FALSE, themeDots = FALSE, checkbox = TRUE)
                                                                                         )
                                                                         )
                                                                         )
                                                               ),
                                                               
                                                               tags$div( style="display:inline-block; vertical-align: top;",
                                                                         hidden(tags$div(id='treeFor_Imputed_protein',
                                                                                         tagList(
                                                                                           tags$p(tags$b("Imputed protein")),
                                                                                           shinyTree::shinyTree("plotsFor_Imputed_protein",theme="proton", themeIcons = FALSE, themeDots = FALSE, checkbox = TRUE)
                                                                                         )
                                                                         )
                                                                         )
                                                               ),
                                                               
                                                               tags$div( style="display:inline-block; vertical-align: top;",
                                                                         hidden(tags$div(id='treeFor_Imputed_peptide',
                                                                                         tagList(
                                                                                           tags$p(tags$b("Imputed peptide")),
                                                                                           shinyTree::shinyTree("plotsFor_Imputed_peptide",theme="proton", themeIcons = FALSE, themeDots = FALSE, checkbox = TRUE)
                                                                                         )
                                                                         )
                                                                         )
                                                               ),
                                                               
                                                               tags$div( style="display:inline-block; vertical-align: top;",
                                                                         hidden(tags$div(id='treeFor_HypothesisTest_protein',
                                                                                         tagList(
                                                                                           tags$p(tags$b("HypothesisTest protein")),
                                                                                           shinyTree::shinyTree("plotsFor_HypothesisTest_protein",theme="proton", themeIcons = FALSE, themeDots = FALSE, checkbox = TRUE)
                                                                                         )
                                                                         )
                                                                         )
                                                               ),
                                                               tags$div( style="display:inline-block; vertical-align: top;",
                                                                         hidden(tags$div(id='treeFor_HypothesisTest_peptide',
                                                                                         tagList(
                                                                                           tags$p(tags$b("HypothesisTest peptide")),
                                                                                           shinyTree::shinyTree("plotsFor_HypothesisTest_peptide",theme="proton", themeIcons = FALSE, themeDots = FALSE, checkbox = TRUE)
                                                                                         )
                                                                         )
                                                                         )
                                                               )
                                                             ),
                                                             style = "primary")
                        )
                      )),
                      br(),br(),br(),
                      
                      tags$div(
                        tags$div( style="display:inline-block; vertical-align: top;",
                                  moduleStaticDataTableUI("viewDataMining")
                        ),
                        tags$div( style="display:inline-block; vertical-align: top;",
                                  shinyBS::bsCollapse(id = "collapseDataProcessingExport", open = "",
                                                      shinyBS::bsCollapsePanel("Plots for data mining tools", tagList(), style = "primary")
                                  )
                        )
                      )
                    )
           )
           
         )
)
