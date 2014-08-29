#######============================================= Basic Textual Analysis with R ==================================================================#######



#==========================================================================================================================================================#
##============================ Section 0: Load libraries & create custom functions =======================================================================##

library(shiny)
library(shinyIncubator)
library(ggplot2)
library(tm)
library(fastcluster)
library(gsl)
library(topicmodels)









#======================================================================================================================#
#============================= The Shiny application =================================================================##



shinyServer(function(input,output,session){



initialCorpus <- reactive({ 
				if (input$uploadBtn == 0)
				return()
				isolate({
					if (input$corpusType == "userCorpus"){
						userUpload <- reactive ({ input$myPath })
						userFilesPath <- userUpload()$datapath
						myData <- unlist(lapply(userFilesPath, function(x) scan(file=x, what="character", sep="\n")))
					}
					myCorpus <- Corpus(VectorSource(myData))
					return(myCorpus)
				})
			})


output$corpusStatus <- renderPrint({
					if(input$uploadBtn == 0)
					return("No corpus selection made yet...")
					withProgress(session, {
						setProgress(message = "Uploading your corpus...")
						isolate({
							initialCorpus()
						})
					})
			})



#========================================================================================================================#
##============================= Section 2: Pre-processing ==================================================================##



preprocessedCorpus <- reactive({
					if(input$preProcessBtn == 0)
					return()
					isolate({
						originalCorpus <- initialCorpus()
						return(originalCorpus)
					})
			})


output$procCorpusStatus <- renderPrint({
						if(input$preProcessBtn == 0)
						return("No pre-processing applied on Corpus...")
						withProgress(session, {
							setProgress(message = "Processing your corpus...")
							isolate({
								preprocessedCorpus() 
							})
					})
			})



observe({
	if(input$phase == "import" | input$phase == "preprocess" | input$phase == "featureGenerate" | input$phase == "featureSelect"){
		updateTabsetPanel(session, "tabset1", "Corpus Generation")
	} else if(input$phase == "about"){
		updateTabsetPanel(session, "tabset1", "About")
	} else if(input$phase == "userGuide"){
		updateTabsetPanel(session, "tabset1", "User Guide")
	}
	})

})


