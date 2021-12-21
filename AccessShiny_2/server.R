
shinyServer(function(input, output, session) {
  
  # Recherche par produits

  output$x3 = DT::renderDataTable(produits, server = TRUE, options = list(pageLength = 10))
  
  proxy = dataTableProxy('x3')
  observeEvent(input$clear, {
    proxy %>% selectRows(NULL)
  })

  output$x6 = renderDT({
    if (length(input$x3_rows_selected)) {
      sProduit <- produits[input$x3_rows_selected]$denomination
      union_all(
        ### Cas Marquants
        select(CM_Produits,denomination,DCI,idCas) %>%
          inner_join(select(CM_CasMarquant,idCas,numeroCRPV), by = "idCas") %>%
          mutate(TypeSignal="CM") %>%
          rename("NumCRPV/NumSignal" = "numeroCRPV","Id" = "idCas") %>%
          filter (denomination %in% sProduit)
        ,
        ### Biblio
        select(Babibs_Produits,denomination,DCI,IdSignal) %>%
          inner_join(select(Babibs_TbSignal,IdSignal,NumSignal), by = "IdSignal") %>%
          inner_join(select(Babibs_TbBiblio,IdSignal), by = "IdSignal") %>%
          mutate(TypeSignal="Biblio") %>%
          rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") %>%
          filter (denomination %in% sProduit)
      ) %>%
        ### UNC
      union_all( select(Babibs_Produits,denomination,DCI,IdSignal) %>%
          inner_join(select(Babibs_TbSignal,IdSignal,NumSignal), by = "IdSignal") %>%
          inner_join(select(Babibs_TbMesusage,IdSignal), by = "IdSignal") %>%
          mutate(TypeSignal="UNC") %>%
          rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") %>%
          filter (denomination %in% sProduit)
      )
    }
  })
  
  # Recherche par DCI
  
  output$x13 = DT::renderDataTable(produitsDCI, server = TRUE, options = list(pageLength = 10))
  
  proxyDCI = dataTableProxy('x13')
  observeEvent(input$clearDCI, {
    proxyDCI %>% selectRows(NULL)
  })

  output$x23 = DT::renderDataTable(donnees, server = TRUE, options = list(pageLength = 10))

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
  
  output$x16 = renderDT({
    if (length(input$x13_rows_selected)) {
      
      sProduitsDCI <- produitsDCI[input$x13_rows_selected]$DCI
      union_all(
        ### Cas Marquants
        select(CM_Produits,denomination,DCI,idCas) %>%
          inner_join(select(CM_CasMarquant,idCas,numeroCRPV), by = "idCas") %>%
          mutate(TypeSignal="CM") %>%
          rename("NumCRPV/NumSignal" = "numeroCRPV","Id" = "idCas") %>%
          filter (DCI %in% sProduitsDCI)
        ,
        ### Biblio
        select(Babibs_Produits,denomination,DCI,IdSignal) %>%
          inner_join(select(Babibs_TbSignal,IdSignal,NumSignal), by = "IdSignal") %>%
          inner_join(select(Babibs_TbBiblio,IdSignal), by = "IdSignal") %>%
          mutate(TypeSignal="Biblio") %>%
          rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") %>%
          filter (DCI %in% sProduitsDCI)
      ) %>%
        ### UNC
        union_all( select(Babibs_Produits,denomination,DCI,IdSignal) %>%
                     inner_join(select(Babibs_TbSignal,IdSignal,NumSignal), by = "IdSignal") %>%
                     inner_join(select(Babibs_TbMesusage,IdSignal), by = "IdSignal") %>%
                     mutate(TypeSignal="UNC") %>%
                     rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") %>%
                     filter (DCI %in% sProduitsDCI)
        )
    }
  })
})

