
shinyServer(function(input, output, session) {
  
  # Recherche par produits

  output$x3 = DT::renderDataTable(produits, server = TRUE, options = list(pageLength = 10))
  
  proxy = dataTableProxy('x3')
  observeEvent(input$clear, {
    proxy %>% selectRows(NULL)
  })
  
  # Affichage des indices sélectionnés
  output$x4 = renderPrint({
    sDeno = input$x3_rows_selected
    if (length(sDeno)) {
      cat('sDeno sélectionnées :\n\n')
      cat(sDeno, sep = ', ')
    }
  })
  
  # Affichage des DCI sélectionnés
  output$x5 = renderPrint({
    sDeno = input$x3_rows_selected
    if (length(sDeno)) {
      cat('Lignes sélectionnées :\n\n')
      print(produits[sDeno,1], sep = ', ')
    }
  })
  output$x6 = renderDT({
    if (length(input$x3_rows_selected)) {
      sProduit <- produits[input$x3_rows_selected,]$denomination
      
      # union_all(
      #   ### Cas Marquants
      #   select(CM_Produits,denomination,DCI,idCas) %>%
      #     inner_join(select(CM_CasMarquant,idCas,numeroCRPV), by = "idCas") %>%
      #     mutate(TypeSignal="CM") %>%
      #     rename("NumCRPV/NumSignal" = "numeroCRPV","Id" = "idCas") %>%
      #     filter (denomination %in% sProduit)
      #   ,
      #   ### Biblio
      #   select(Babibs_Produits,denomination,DCI,IdSignal) %>%
      #     inner_join(select(Babibs_TbSignal,IdSignal,NumSignal), by = "IdSignal") %>%
      #     inner_join(select(Babibs_TbBiblio,IdSignal), by = "IdSignal") %>%
      #     mutate(TypeSignal="Biblio") %>%
      #     rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") %>%
      #     filter (denomination %in% sProduit)
      # ) %>%
      #   ### UNC
      # union_all( select(Babibs_Produits,denomination,DCI,IdSignal) %>%
      #     inner_join(select(Babibs_TbSignal,IdSignal,NumSignal), by = "IdSignal") %>%
      #     inner_join(select(Babibs_TbMesusage,IdSignal), by = "IdSignal") %>%
      #     mutate(TypeSignal="UNC") %>%
      #     rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") %>%
      #     filter (denomination %in% sProduit)
      # )
      
      union_all(
      ### Cas Marquants
      pool %>% tbl("cm_produits") %>% select(denomination,DCI,idCas) %>%
        inner_join((pool %>% tbl("cm_casmarquant") %>% select(idCas,numeroCRPV)), by = "idCas") %>%
        mutate(TypeSignal="CM") %>%
        rename("NumCRPV/NumSignal" = "numeroCRPV","Id" = "idCas") %>%
        filter (denomination %in% sProduit) %>% collect()
      ,
      ### Biblio
      pool %>% tbl("babibs_produits") %>% select(denomination,DCI,IdSignal) %>%
        inner_join((pool %>% tbl("babibs_tbsignal") %>% select(IdSignal,NumSignal)), by = "IdSignal") %>%
        inner_join((pool %>% tbl("babibs_tbbiblio") %>% select(IdSignal)), by = "IdSignal") %>%
        mutate(TypeSignal="Biblio") %>%
        rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") %>%
        filter (denomination %in% sProduit) %>% collect()
      ) %>% 
      union_all( 
      ### UNC
      pool %>% tbl("babibs_produits") %>% select(denomination,DCI,IdSignal) %>%
        inner_join((pool %>% tbl("babibs_tbsignal") %>% select(IdSignal,NumSignal)), by = "IdSignal") %>%
        inner_join((pool %>% tbl("babibs_tbmesusage") %>% select(IdSignal)), by = "IdSignal") %>%
        mutate(TypeSignal="UNC") %>%
        rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") %>%
        filter (denomination %in% sProduit) %>% collect()
      )
    }
  })
  
  # Recherche par DCI
  
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
  
  output$x16 = renderDT({
    if (length(input$x13_rows_selected)) {
      
      sProduitsDCI <- produitsDCI[input$x13_rows_selected,1]

      union_all(
        ### Cas Marquants
        pool %>% tbl("cm_produits") %>% select(denomination,DCI,idCas) %>%
          inner_join((pool %>% tbl("cm_casmarquant") %>% select(idCas,numeroCRPV)), by = "idCas") %>%
          mutate(TypeSignal="CM") %>%
          rename("NumCRPV/NumSignal" = "numeroCRPV","Id" = "idCas") %>%
          filter (DCI %in% sProduitsDCI) %>% collect()
        ,
        ### Biblio
        pool %>% tbl("babibs_produits") %>% select(denomination,DCI,IdSignal) %>%
          inner_join((pool %>% tbl("babibs_tbsignal") %>% select(IdSignal,NumSignal)), by = "IdSignal") %>%
          inner_join((pool %>% tbl("babibs_tbbiblio") %>% select(IdSignal)), by = "IdSignal") %>%
          mutate(TypeSignal="Biblio") %>%
          rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") %>%
          filter (DCI %in% sProduitsDCI) %>% collect()
      ) %>%
        union_all(
          ### UNC
          pool %>% tbl("babibs_produits") %>% select(denomination,DCI,IdSignal) %>%
            inner_join((pool %>% tbl("babibs_tbsignal") %>% select(IdSignal,NumSignal)), by = "IdSignal") %>%
            inner_join((pool %>% tbl("babibs_tbmesusage") %>% select(IdSignal)), by = "IdSignal") %>%
            mutate(TypeSignal="UNC") %>%
            rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") %>%
            filter (DCI %in% sProduitsDCI) %>% collect()
        )
      
      
  #     union_all(
  #       ### Cas Marquants
  #       select(CM_Produits,denomination,DCI,idCas) %>%
  #         inner_join(select(CM_CasMarquant,idCas,numeroCRPV), by = "idCas") %>%
  #         mutate(TypeSignal="CM") %>%
  #         rename("NumCRPV/NumSignal" = "numeroCRPV","Id" = "idCas") %>%
  #         filter (DCI %in% sProduitsDCI)
  #       ,
  #       ### Biblio
  #       select(Babibs_Produits,denomination,DCI,IdSignal) %>%
  #         inner_join(select(Babibs_TbSignal,IdSignal,NumSignal), by = "IdSignal") %>%
  #         inner_join(select(Babibs_TbBiblio,IdSignal), by = "IdSignal") %>%
  #         mutate(TypeSignal="Biblio") %>%
  #         rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") %>%
  #         filter (DCI %in% sProduitsDCI)
  #     ) %>%
  #       ### UNC
  #       union_all( select(Babibs_Produits,denomination,DCI,IdSignal) %>%
  #                    inner_join(select(Babibs_TbSignal,IdSignal,NumSignal), by = "IdSignal") %>%
  #                    inner_join(select(Babibs_TbMesusage,IdSignal), by = "IdSignal") %>%
  #                    mutate(TypeSignal="UNC") %>%
  #                    rename("NumCRPV/NumSignal" = "NumSignal","Id" = "IdSignal") %>%
  #                    filter (DCI %in% sProduitsDCI)
  #       )
    }
  })

  # output$x23 = DT::renderDataTable(donnees, server = TRUE, options = list(pageLength = 10))  
  output$ActMesNonMEO <- renderTable({
    # head(datasetInput(), n = isolate(input$obs))
    # dbGetQuery(pool, "SELECT COUNT(*) AS 'Nb', DATE_FORMAT(datePrevision,'%Y/S%u') AS 'Année/Semaine' FROM cm_tbmesurescalendrier 
    #                   WHERE cm_tbmesurescalendrier.dateMiseOeuvre IS NULL AND cm_tbmesurescalendrier.datePrevision IS NOT NULL
    #                   GROUP BY DATE_FORMAT(cm_tbmesurescalendrier.datePrevision,'%Y/S%u')
    #                   ORDER BY DATE_FORMAT(cm_tbmesurescalendrier.datePrevision,'%Y/S%u')"
    #            )
    # testActMes
    
  })
  
  output$ActMesNonMEOPlot <- renderPlot({
    # head(datasetInput(), n = isolate(input$obs))
    # dbGetQuery(pool, "SELECT COUNT(*) AS 'Nb', DATE_FORMAT(datePrevision,'%Y/S%u') AS 'Année/Semaine' FROM cm_tbmesurescalendrier
    #                   WHERE cm_tbmesurescalendrier.dateMiseOeuvre IS NULL AND cm_tbmesurescalendrier.datePrevision IS NOT NULL
    #                   GROUP BY DATE_FORMAT(cm_tbmesurescalendrier.datePrevision,'%Y/S%u')
    #                   ORDER BY DATE_FORMAT(cm_tbmesurescalendrier.datePrevision,'%Y/S%u')"
    #            )
    testActMes3<-dbGetQuery(pool, "SELECT idMesure, DATE(datePrevision) AS 'datePrev', datePrevision FROM cm_tbmesurescalendrier 
                                    WHERE dateMiseOeuvre IS NULL 
                                      AND datePrevision IS NOT NULL 
                                      AND (datePrevision BETWEEN '2018-01-30 00:00:00' AND '2021-09-29 00:00:00')
                                    ORDER BY datePrevision ASC;"
    )
    ggplot(data = testActMes3, mapping = aes(x=datePrev)) + geom_histogram()
    # plot(cars2)
  })
  
  
  # Affichage des indices sélectionnés
  output$x24 = renderPrint({
    
    # date_start <- input$datePrev[1]
    # date_end <- input$datePrev[2]
    # dateSelect <- as.Date(input$datePrev, origin = "1970-01-01")
    # sDCI = input$x13_rows_selected
    # if (length(sDCI)) {
      cat('Date sélectionnées :\n\n')
      print (as.Date(input$datePrev[1], origin = "1970-01-01"), sep = ', ')
      print (as.Date(input$datePrev[2], origin = "1970-01-01"), sep = ', ')
    # }
  })
})

