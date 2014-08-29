


library(shiny)
library(shinyIncubator)




shinyUI(pageWithSidebar(
				headerPanel(
					"Exploratory Qualitative Analysis with R",
					windowTitle = "Exploring Textual Data with R"),


sidebarPanel(tags$h4("Phase Selection"),

		br(),

		progressInit(),
		selectInput("phase", "Which phase would you like to choose?",
				c("User Guide" = "userGuide",
				"1. Importing Corpus" = "import",
				"2. Pre-processing" = "preprocess")),

		br(),

		conditionalPanel(
			condition = "input.phase == 'import'",
			wellPanel(tags$strong("Importing a Corpus"),
				selectInput("corpusType", "Select the type of Corpus?",
					c("Use Personal Corpus" = "userCorpus",
				  	"Use Sample Corpus" = "sampleCorpus")),
				conditionalPanel(
					condition = "input.corpusType == 'userCorpus'",
					fileInput("userPath", "", multiple=TRUE)
					),
			actionButton("uploadBtn", "Upload Corpus")
			)
		),		

		conditionalPanel(
			condition = "input.phase == 'preprocess'",
			wellPanel(tags$strong("Pre-processing on Corpus"),
				checkboxInput("punctuation", "Punctuation Removal", FALSE),
				checkboxInput("numbers", "Numbers Removal", FALSE),
				checkboxInput("stemming", "Stem Words", FALSE),
				checkboxInput("stopwords", "Stopwords Removal", FALSE),
				checkboxInput("customStopword", "Custom Stopwords", FALSE),
				conditionalPanel(
					condition = "input.customStopword",
					textInput("cusStopwords", "Please enter your stopwords separated by comma")
					),
				checkboxInput("customThes", "Custom Thesaurus", FALSE),
				conditionalPanel(
					condition = "input.customThes",
					textInput("customThesInitial", "Please enter words separated by comma"),
					textInput("customThesReplacement", "Enter Replacement words")
					),

				br(),

				actionButton("preProcessBtn", "Apply Pre-processing")
			)
		)

	),				


##================================= Select settings for mainPanel ================================================##

	mainPanel(
		tabsetPanel(id = "tabset1",
			tabPanel(title = "User Guide", includeHTML("introduction.html")),
			tabPanel(title = "Corpus Generation", verbatimTextOutput("corpusStatus"), verbatimTextOutput("procCorpusStatus"), verbatimTextOutput("initialuniMatrix"), verbatimTextOutput("finaluniMatrix")),
			tabPanel(title = "About", includeHTML("about.html"))
			)
		)
))
