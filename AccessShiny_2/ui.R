
fluidPage(tabsetPanel(
  # navbarPage("Shiny Access",
             
    tabPanel("Recherche de produit",
      fluidPage(
        h1('Liste des médicaments par produit'),
        
        fluidRow(
          column(11, DT::dataTableOutput('x3')),
          column(1, actionButton('clear', 'Remise à zéro')),
          column(6, verbatimTextOutput('x4')),
          column(6, verbatimTextOutput('x5')),
          column(12, DTOutput('x6'))
        )
      )
    ),
    tabPanel("Recherche de DCI"
              ,
       fluidPage(
         h1('Liste des médicaments par DCI'),
         
        fluidRow(
          column(11, DT::dataTableOutput('x13')),
          column(1, actionButton('clearDCI', 'Remise à zéro')),
          column(6, verbatimTextOutput('x14')),
          column(6, verbatimTextOutput('x15')),
          column(12, DTOutput('x16'))
  
        )
      )
    ),
    # tabPanel("test pool"
    #          ,
    #          fluidPage(
    #            h1('Liste de la table CasMarquant'),
    #            
    #            fluidRow(
    #              column(11, DT::dataTableOutput('x23')),
    #              # column(1, actionButton('clearDCI', 'Remise à zéro')),
    #              # column(6, verbatimTextOutput('x24')),
    #              # column(6, verbatimTextOutput('x25')),
    #              # column(12, DTOutput('x26'))
    #              
    #     )
    #   )
    # )
  )
)
  

