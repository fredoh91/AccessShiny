

library(shiny)
library(DT)
library(dplyr)
library(data.table)

shinyServer(function(input, output, session) {
  
  
  # Recherche par produits
  produits2 = produits[, 1:2]
  
  output$x3 = DT::renderDataTable(produits2, server = TRUE, options = list(pageLength = 10))
  
  proxy = dataTableProxy('x3')
  observeEvent(input$clear, {
    proxy %>% selectRows(NULL)
  })

  
  # Affichage des indices sélectionnés
  output$x4 = renderPrint({
    s = input$x3_rows_selected
    if (length(s)) {
      cat('Lignes sélectionnées :\n\n')
      cat(s, sep = ', ')
    }
  })  
  
  # Affichage des produits sélectionnés
  output$x5 = renderPrint({
    s <- input$x3_rows_selected
    sProduit <- c(produits2[input$x3_rows_selected,1])
    if (length(s)) {
      cat('Lignes sélectionnées :\n\n')
      # cat(produits2[s,1], sep = ', ')
      # print(produits2[s,1], sep = ', ')
      print(sProduit)
      # print(str(sProduit))
      # print(count(sProduit))
      
      # print(produits2 %>% filter %in% c(produits2[input$x3_rows_selected,1]))
      # print(produits2 %>% filter (denomination %in% c("ABILIFY")))
    }
  })
  # 
  # # Affichage des produits par requête
  # testprod <- reactive(
  #   if (length(input$x3_rows_selected)) {
  #     sProduit = c(produits2[input$x3_rows_selected,1])
  #     
  #     
  # 
  #     ### Cas Marquants
  #     CM_tempo <- data.table(select(CM_Produits,denomination,DCI,idCas) %>%
  #       inner_join(select(CM_CasMarquant,idCas,numeroCRPV), by = "idCas") %>%
  #       mutate(TypeSignal="CM") %>%
  #       rename("NumCRPV/NumSignal" = "numeroCRPV","Id" = "idCas") )
  #     # %>%
  #     #   filter (denomination %in% sProduit)
  #     # filter (denomination %in% c("ABILIFY","ABILIFY 1 mg/ml, solution buvable"))
  #     # filter (denomination %in% c(produits2[input$x3_rows_selected,1]))
  #     
  #     
  #     ### Biblio
  #     Biblio_tempo <- data.table(select(Babibs_Produits,denomination,DCI,IdSignal) %>%
  #       inner_join(select(Babibs_TbSignal,IdSignal,NumSignal), by = "IdSignal") %>%
  #       inner_join(select(Babibs_TbBiblio,IdSignal), by = "IdSignal") %>%
  #       mutate(TypeSignal="Biblio") %>%
  #       rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") )
  #     # %>%
  #     #   filter (denomination %in% sProduit)
  #     
  #     
  #     # CM_Biblio <- union_all(CM_tempo, Biblio_tempo) %>% filter (denomination %in% sProduit)
  #     CM_Biblio <- union_all(CM_tempo[denomination  %in% sProduit], Biblio_tempo[denomination  %in% sProduit])
  # 
  #     cat(file=stderr(),str(sProduit))
  #     # browser()
  #     # cat(file=stderr(),str(union_all(CM_tempo,Biblio_tempo)))
  #     cat(file=stderr(),str(CM_Biblio))
  #   }    
  # )

  
  output$x6 = renderDT({
    if (length(input$x3_rows_selected)) {
      
      # testprod()
      
      
    #   produits2 %>% filter (denomination %in% c(produits2[input$x3_rows_selected,1]))
      # CM_Produits %>% left_join(CM_CasMarquant, by="idCas") %>% filter (denomination %in% c(produits2[input$x3_rows_selected,1]))
      # CM_Produits %>% left_join(mutate(CM_CasMarquant,TypeSignal="CM"), by="idCas") %>% filter (denomination %in% c(produits2[input$x3_rows_selected,1])) %>% select(DCI,denomination,codeATC,numeroCRPV,TypeSignal)
      # CM_Produits %>% left_join(mutate(CM_CasMarquant,TypeSignal="CM"), by="idCas") %>% filter (denomination %in% c(produits2[input$x3_rows_selected,1])) %>% select(DCI,denomination,codeATC,numeroCRPV,TypeSignal)
      # Babibs_Produits %>% left_join(Babibs_TbSignal, by="IdSignal") %>% left_join(mutate(Babibs_TbBiblio,TypeSignal="Biblio"), by="IdSignal") %>% filter (denomination %in% c(produits2[input$x3_rows_selected,1]))
      # Babibs_Produits %>% 
      #   filter (Babibs_Produits$denomination %in% c(produits2[input$x3_rows_selected,1])) %>% 
      #   left_join(Babibs_TbSignal, by = c("Babibs_Produits$IdSignal" = "Babibs_TbSignal$IdSignal")) %>% 
      #   inner_join(Babibs_TbBiblio, by = c("Babibs_Produits$IdSignal" = "Babibs_TbBiblio$IdSignal")) %>% mutate(Babibs_TbBiblio,TypeSignal="Biblio")
      # Babibs_Produits %>% 
      #   filter (Babibs_Produits$denomination %in% c(produits2[input$x3_rows_selected,1])) %>% 
      #   inner_join(Babibs_TbSignal, Babibs_TbBiblio, by = "IdSignal") %>% 
      #   select(Babibs_Produits$DCI,Babibs_Produits$denomination,Babibs_Produits$codeATC,Babibs_TbBiblio$IdBiblio)
      
      # Babibs_Produits %>% 
      #   inner_join(Babibs_TbSignal, Babibs_TbBiblio, by = "IdSignal") %>%
      #   filter (Babibs_Produits$denomination %in% c(produits2[input$x3_rows_selected,1])) 
      
      # sProduit <- c(produits2[input$x3_rows_selected,1])
      
      sProduit <- produits2[input$x3_rows_selected]$denomination
      union_all(
        ### Cas Marquants
        select(CM_Produits,denomination,DCI,idCas) %>%
          inner_join(select(CM_CasMarquant,idCas,numeroCRPV), by = "idCas") %>%
          mutate(TypeSignal="CM") %>%
          rename("NumCRPV/NumSignal" = "numeroCRPV","Id" = "idCas") %>%
          filter (denomination %in% sProduit)
          # filter (denomination %in% c("ABILIFY","ABILIFY 1 mg/ml, solution buvable"))
          # filter (denomination %in% c(produits2[input$x3_rows_selected,1]))
        
        ,
        ### Biblio
        select(Babibs_Produits,denomination,DCI,IdSignal) %>%
          inner_join(select(Babibs_TbSignal,IdSignal,NumSignal), by = "IdSignal") %>%
          inner_join(select(Babibs_TbBiblio,IdSignal), by = "IdSignal") %>%
          mutate(TypeSignal="Biblio") %>%
          rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") %>%
          filter (denomination %in% sProduit)
          # filter (denomination %in% c(produits2[input$x3_rows_selected,1]))
      )
      
    }
  })
  
  # Recherche par DCI
  # produits2DCI = produitsDCI[, 1:1]

  output$x13 = DT::renderDataTable(produitsDCI, server = TRUE, options = list(pageLength = 10))
  
  proxyDCI = dataTableProxy('x13')
  observeEvent(input$clearDCI, {
    proxyDCI %>% selectRows(NULL)
  })

  # Affichage des indices sélectionnés
  output$x14 = renderPrint({
    sDCI = input$x13_rows_selected
    if (length(sDCI)) {
      cat('Lignes sélectionnées :\n\n')
      cat(sDCI, sep = ', ')
    }
  })

  # Affichage des DCI sélectionnés
  output$x15 = renderPrint({
    sDCI = input$x13_rows_selected
    if (length(sDCI)) {
      cat('Lignes sélectionnées :\n\n')
      print(produitsDCI[sDCI,1], sep = ', ')
    }
  })
  
})

