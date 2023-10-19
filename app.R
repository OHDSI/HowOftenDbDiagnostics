schema <- Sys.getenv("dbDiagnosticsdbSchema", unset="public")
library(ShinyAppBuilder)
config <- initializeModuleConfig() |>
  addModuleConfig(
    ShinyAppBuilder::createModuleConfig(
      moduleIcon = "table",
      moduleId = 'EvidenceSynthesis',
      tabName = 'DbDiagnostic',
      shinyModulePackage = "OhdsiShinyModules",
      moduleUiFunction = "dataDiagnosticViewer",
      moduleServerFunction = "dataDiagnosticServer",
      moduleInfoBoxFile = "dataDiagnosticHelperFile()"
    )
  )

# specify the connection to the results database
connectionDetails <- DatabaseConnector::createConnectionDetails(
  dbms = 'postgresql',
  user = Sys.getenv("dbDiagnosticsdbUser"),
  password = Sys.getenv("dbDiagnosticsdbPw"),
  server = Sys.getenv("dbDiagnosticsdbServer")
)

# now create the shiny app based on the config file and view the results
# based on the connection
#strong <- shiny::strong
ShinyAppBuilder::createShinyApp(config = config, 
                                connectionDetails = connectionDetails, 
                                resultDatabaseSettings = createDefaultResultDatabaseSettings(schema=schema))