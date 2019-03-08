####Preliminary####
## Author: Talia Al-Mushadani (ta1915)
## Script: Condition_Selection_AND_Model_Fitting.R
## Date: 28/11/18
## Version: 1.0.0

rm(list=ls())
graphics.off()

#packages
require(minpack.lm)
require(stats)
require(truncnorm)
require(ggplot2)
require(compiler)

enableJIT(3)

##assign k in .GlovalEnv
assign("k", 8.617 * 10^-5, envir = .GlobalEnv)

####functions for models####

##Gillooly model including mass of the consumer (2001)
Gillooly <- function(logI0, Ei, temp){
  IM = logI0 - (Ei/k * (1/temp - 1/283.15))
  return(IM)
}

Gillooly <- cmpfun(Gillooly)

##Simplified Schoolfield model without low-temperature inactivation (1981)
Schoolfield <- function(logB0, E, Eh, Th, temp){
  B = logB0 + log(exp((-E/k) * ((1/temp) - (1/283.15)))/(1 + exp(Eh/k * (1/Th - 1/temp))))
  return(B)
}

Schoolfield <- cmpfun(Schoolfield)

####functions to get starting conditions####

GetT_pk <- function(dataset){
  return(max(dataset$ConTempK[which.max(dataset$OriginalTraitValue)]))
}

GetT_pk <- cmpfun(GetT_pk)

GetlogB0 <- function(dataset){
  return(log(min(dataset$OriginalTraitValue)))
}

GetlogB0 <- cmpfun(GetlogB0)

GetLHS <- function(dataset){
  T_pk = GetT_pk(dataset = dataset)
  dataLHS <- subset(dataset, dataset[, "ConTempK"] <= T_pk)
  return(dataLHS)
}

GetLHS <- cmpfun(GetLHS)

GetRHS <- function(dataset){
  T_pk = GetT_pk(dataset = dataset)
  dataRHS <- subset(dataset, dataset[, "ConTempK"] >= T_pk)
  return(dataRHS)
}

GetRHS <- cmpfun(GetRHS)

GetEi <- function(dataset){ #uses entire dataset
  data <- subset(dataset, dataset[, "ConTempK"] <= 313.15)
  x = 1/(k * data$ConTempK)
  y = log((data$OriginalTraitValue)/((data$ConMassG)^(0.75)))
  fit = summary(lm(y ~ x))
  actual = abs(fit$coefficients[2])
  return(actual)
}

GetEi<- cmpfun(GetEi)

GetlogI0 <- function(dataset){ #uses entire dataset
  data <- subset(dataset, dataset[, "ConTempK"] <= 313.15)
  x = 1/(k * data$ConTempK)
  y = log((data$OriginalTraitValue)/((data$ConMassG)^(0.75)))
  fit = summary(lm(y ~ x))
  actual = fit$coefficients[1]
  return(actual)
}

GetlogI0 <- cmpfun(GetlogI0)

GetE <- function(dataset){ #uses LHS dataset
  if (length(unique(dataset$ConTempK)) > 1 ) {
    x <- 1/(k * dataset$ConTempK)
    y <- log(dataset$OriginalTraitValue)
    fit <- summary(lm(y ~ x))
    E_strt <- abs(fit$coefficients[2])
  } else { E_strt <- 0.7}
  return(E_strt)
}

GetE <- cmpfun(GetE)

GetEh <- function(dataset){ #uses RHS dataset
  E_strt = GetE(dataset = dataset)
  if (length(unique(dataset$ConTempK)) > 1 ) { 
    x <- 1/(k * dataset$ConTempK)
    y <- log(dataset$OriginalTraitValue)
    fit <- summary(lm(y ~ x))
    Eh_strt <- abs(fit$coefficients[2])
  } else{ Eh_strt <- E_strt*1.1}
  return(Eh_strt)
}

GetEh <- cmpfun(GetEh)

GetTh <- function(dataset){ #uses RHS dataset
  T_pk = GetT_pk(dataset = dataset)
  if (length(unique(dataset$ConTempK)) > 1 ) { 
    x <- 1/(k * dataset$ConTempK)
    y <- log(dataset$OriginalTraitValue)
    fit <- summary(lm(y ~ x))
    intercept = fit$coefficients[1]
    slope = abs(fit$coefficients[2])
    z = (mean(y) - intercept)/slope
    Th_strt = 1/(k * z)
  } else { Th_strt <- T_pk}
  return(Th_strt)
}

GetTh <- cmpfun(GetTh)

####functions to vary starting parameters with each loop iteration####
#varies Ei for Gillooly tryCatch
Randomise_Parameters_Gillooly <- function(mean_logI0, mean_Ei){
  mean_I0 <- exp(mean_logI0)
  random_logI0 <- log(rtruncnorm(n = 1,a = 0, b = Inf, mean = mean_I0, sd = mean_I0/2))
  random_Ei <- abs(rtruncnorm(n = 1, a = 0, b = Inf, mean = mean_Ei, sd = 2))
  return(c(random_logI0, random_Ei))
}

Randomise_Parameters_Gillooly <- cmpfun(Randomise_Parameters_Gillooly)

#varies logB0, E, Eh and Th for Schoolfield tryCatch
Randomise_Parameters_Schoolfield <- function(mean_logB0, mean_E, mean_Eh, mean_Th){
  mean_B0 <- exp(mean_logB0)
  random_logB0 <- log(rtruncnorm(n = 1,a = 0, b = Inf, mean = mean_B0, sd = mean_B0/2))
  random_E <- abs(rtruncnorm(n = 1, a = 0,b = Inf, mean = mean_E, sd = 2))
  random_Eh <- abs(rtruncnorm(n = 1,a = 0,b = Inf, mean = mean_Eh, sd = 2))
  random_Th <- abs(rnorm(1, mean = mean_Th, sd = 5))
  return(c(random_logB0, random_E, random_Eh, random_Th))
}

Randomise_Parameters_Schoolfield <- cmpfun(Randomise_Parameters_Schoolfield)

####functions to run fitting of Gillooly & Schoolfield models####

#function for Gillooly
Fitting_tryCatch_Gillooly <- function(logI0, Ei, dataset){
  Gillooly_nls <- NA
  logI0_mean = logI0
  Ei_mean = Ei
  for (i in 1:500){
    Gillooly_nls <- tryCatch({nlsLM(log(OriginalTraitValue) ~ Gillooly(logI0, Ei, ConTempK), start = c(logI0 = logI0, Ei = Ei), lower = c(logI0 = -Inf, Ei = 0), upper = c(logI0 = Inf, Ei = Inf), data = dataset, control = list(maxiter = 1000, ftol = .Machine$double.eps, ptol = .Machine$double.eps, maxfev = 1000))},
                                error = function(e){
                                  out <<- NULL
                                  return(NULL)})
    if (!is.null(Gillooly_nls)){
      break
    } else { 
      new_parameters <- Randomise_Parameters_Gillooly(mean_logI0 = logI0_mean, mean_Ei = Ei_mean)
      logI0 = new_parameters[1]
      Ei = new_parameters[2]
    }
  }
  return(Gillooly_nls)
}

Fitting_tryCatch_Gillooly <- cmpfun(Fitting_tryCatch_Gillooly)

#function for Schoolfield
Fitting_tryCatch_Schoolfield <- function(logB0, E, Eh, Th, dataset){
  Schoolfield_nls <- NA
  logB0_mean = logB0
  E_mean = E
  Eh_mean = Eh
  Th_mean = Th
  for (i in 1:500){
    Schoolfield_nls <- tryCatch({nlsLM(log(OriginalTraitValue) ~ Schoolfield(logB0, E, Eh, Th, ConTempK), start = c(logB0 = logB0, E = E, Eh = Eh, Th = Th), lower = c(logB0 = -Inf, E = 0, Eh = 0, Th = 273.15), upper = c(logB0 = Inf, E = Inf, Eh = Inf, Th = Inf), data = dataset, control = list(maxiter = 1000, ftol = .Machine$double.eps, ptol = .Machine$double.eps, maxfev = 1000))},
           error = function(e){
             out <<- NULL
             return(NULL)})
    if (!is.null(Schoolfield_nls)){
      break
    } else { 
      new_parameters <- Randomise_Parameters_Schoolfield(mean_logB0 = logB0_mean, mean_E = E_mean, mean_Eh = Eh_mean, mean_Th = Th_mean)
    logB0 = new_parameters[1]
    E = new_parameters[2]
    Eh = new_parameters[3]
    Th = new_parameters[4]
    }
  }
  return(Schoolfield_nls)
}

Fitting_tryCatch_Schoolfield <- cmpfun(Fitting_tryCatch_Schoolfield)

####fitting & selection of models####

TPCfit <- function(){
  # load in data
  biotraits <- read.csv('../Data/condensed_biotraits.csv')

  #initialise empty vectors to store parameter estimates that are obtained
  B0_Cub = c()
  B1_Cub = c()
  B2_Cub = c()
  B3_Cub = c()
  AIC_Cub = c()
  
  logI0_Gill = c()
  I0_Gill = c()
  Ei_Gill = c()
  AIC_Gill = c()
  
  logB0_Sch = c()
  B0_Sch = c()
  E_Sch = c()
  Eh_Sch = c()
  Th_Sch = c()
  AIC_Sch = c()
  
  Selected_Model = c()
  
  #initialise empty dataframe to store output values for each experiment ID
  Results = setNames(data.frame(matrix(ncol = 18, nrow = 0)), c('FinalID', 'OriginalTraitName', 'B0_Cub', 'B1_Cub', 'B2_Cub', 'B3_Cub', 'logI0_Gill', 'I0_Gill', 'Ei_Gill', 'E_Sch', 'logB0_Sch', 'B0_Sch', 'Eh_Sch', 'Th_Sch', 'AIC_Cub', 'AIC_Gill', 'AIC_Sch', 'Selected_Model'))
  
  #generate list of IDs
  
  ID = unique(biotraits$FinalID)
  
  #fitting steps
  
  for (i in 1:length(ID)){
    #subset data per experiment
    c_d = biotraits[biotraits$FinalID == ID[i],]
    
    ScalingFactor <- NA
    if (any(c_d$OriginalTraitValue <= 0)){
      ScalingFactor <- min(c_d$OriginalTraitValue)
      c_d$OriginalTraitValue <- (c_d$OriginalTraitValue - min(c_d$OriginalTraitValue))
      c_d <- c_d[-which(c_d$OriginalTraitValue == min(c_d$OriginalTraitValue)),]
    }
    
    #generate vectors containing FinalID & Original Trait Name of the data being used to fit the models
    uniqueID = as.character(unique(c_d$FinalID))
    uniqueTrait = as.character(unique(c_d$OriginalTraitName))

    #estimate parameters
    logB0p = GetlogB0(dataset = c_d)
    logI0p = GetlogI0(dataset = c_d)
    Eip = GetEi(dataset = c_d)
    LHS = GetLHS(dataset = c_d)
    RHS = GetRHS(dataset = c_d)
    Ep = GetE(dataset = LHS)
    Ehp = GetEh(dataset = RHS)
    Thp = GetTh(dataset = RHS)
    
    #actual fitting
    
    #Cubic model
    
    Cubic = lm(formula = OriginalTraitValue ~ poly(ConTempK, 3), data = c_d)
    B0_Cub = as.numeric(coef(Cubic)[1])
    B1_Cub = as.numeric(coef(Cubic)[2])
    B2_Cub = as.numeric(coef(Cubic)[3])
    B3_Cub = as.numeric(coef(Cubic)[4])
    AIC_Cub = AIC(Cubic)
    
    ##Gillooly model
    
    Gillooly_fitted <- Fitting_tryCatch_Gillooly(logI0 = logI0p, Ei = Eip, dataset = c_d)
    
    logI0_Gill = as.numeric(coef(Gillooly_fitted)["logI0"])
    I0_Gill = exp(logI0_Gill)
    Ei_Gill = as.numeric(coef(Gillooly_fitted)["Ei"])
    AIC_Gill = AIC(Gillooly_fitted)
    
    #Schoolfield Model
    
    Schoolfield_fitted <- Fitting_tryCatch_Schoolfield(logB0 = logB0p, E = Ep, Eh = Ehp, Th = Thp, dataset = c_d)
    
    logB0_Sch = as.numeric(coef(Schoolfield_fitted)["logB0"])
    B0_Sch = exp(logB0_Sch)
    E_Sch = as.numeric(coef(Schoolfield_fitted)["E"])
    Eh_Sch = as.numeric(coef(Schoolfield_fitted)["Eh"])
    Th_Sch = as.numeric(coef(Schoolfield_fitted)["Th"])
    AIC_Sch = AIC(Schoolfield_fitted)
    
    #Plotting
    output_name <- paste('../Results/Model_Fitting/', uniqueID, '_Cubic_Gillooly_Schoolfield.pdf', sep = '')
     
    actual_data_points <- data.frame(Temperature = c_d$ConTempK, TraitValue = c_d$OriginalTraitValue)
     
    temps = seq(from = min(floor(c_d$ConTempK)), to = max(ceiling(c_d$ConTempK)), length.out = 200)
     
    mass = seq(from = min(floor(c_d$ConMassG)), to = max(ceiling(c_d$ConMassG)), length.out = 200)
    mass_factor = mass^(0.75)
     
    Cubic_model = predict(Cubic, newdata = data.frame(ConTempK = temps))
    DFtoPlotCubic = data.frame(Temperature = temps, TraitValue = Cubic_model)
    
    Gill_model = exp(Gillooly(logI0 = logI0_Gill, Ei = Ei_Gill, temp = temps))
    non_mass_corrected_Gill_model = Gill_model*mass_factor
    DFtoPlotGillooly = data.frame(Temperature = temps, TraitValue = non_mass_corrected_Gill_model)
    
    School_model = exp(Schoolfield(logB0 = logB0_Sch, E = E_Sch, Eh = Eh_Sch, Th = Th_Sch, temp = temps))
    DFtoPlotSchoolfield = data.frame(Temperature = temps, TraitValue = School_model)
    
    units = paste('(', as.character(unique(c_d$OriginalTraitUnit)), ')', sep = '')
     
    plots <- ggplot() + geom_point(data = actual_data_points, aes(x = Temperature, y = TraitValue), size = 2, col = '#648FFF', bg = '#FFE3A4', alpha = 0.8, pch = 21) +
           geom_line(data = DFtoPlotCubic, aes(x = Temperature, y = TraitValue, colour = "Cubic"), lwd = 1.3) + 
      geom_line(data = DFtoPlotGillooly, aes(x = Temperature, y = TraitValue, colour = 'Gillooly'), lwd = 1.3) + 
      geom_line(data = DFtoPlotSchoolfield, aes(x = Temperature, y = TraitValue, colour = 'Schoolfield'), lwd = 1.3) + scale_colour_manual("", values = c("Cubic" = "#785EF0", "Gillooly" = "#DC267F", "Schoolfield" = "#FE6100")) + ggtitle(uniqueID) + xlab("Temperature (K)") + ylab(paste(uniqueTrait, units, sep = ' ')) + theme_minimal() + theme(plot.title = element_text(size = 12, hjust = 0.5), axis.title = element_text(size = 10))
     
    pdf_file = ggsave(output_name, plot = plots, device = "pdf")
    
      if (is.na(AIC_Cub) && is.na(AIC_Gill) && is.na(AIC_Sch)){
       Selected_Model <- 'NA'
     } else if (is.na(AIC_Cub) && is.na(AIC_Gill) && !is.na(AIC_Sch)){
       Selected_Model <- 'Schoolfield'
     } else if (is.na(AIC_Cub) && !is.na(AIC_Gill) && is.na(AIC_Sch)){
       Selected_Model <- 'Gillooly'
     } else if (!is.na(AIC_Cub) && is.na(AIC_Gill) && is.na(AIC_Sch)){
       Selected_Model <- 'Cubic'
     } else if (AIC_Cub < AIC_Gill && is.na(AIC_Sch)){
       Selected_Model <- 'Cubic'
     } else if (AIC_Cub > AIC_Gill && is.na(AIC_Sch)){
       Selected_Model <- 'Gillooly'
     } else if (is.na(AIC_Cub) && AIC_Gill < AIC_Sch){
       Selected_Model <- 'Gillooly'
     } else if (is.na(AIC_Cub) && AIC_Gill > AIC_Sch){
       Selected_Model <- 'Schoolfield'
     } else if (AIC_Cub < AIC_Sch && is.na(AIC_Gill)){
       Selected_Model <- 'Cubic'
     } else if (AIC_Cub > AIC_Sch && is.na(AIC_Gill)){
       Selected_Model <- 'Schoolfield'
     } else if (AIC_Cub > AIC_Gill && AIC_Gill > AIC_Sch){
       Selected_Model <- 'Schoolfield'
     } else if (AIC_Cub > AIC_Gill && AIC_Gill < AIC_Sch){
       Selected_Model <- 'Gillooly'
     } else if (AIC_Cub < AIC_Gill && AIC_Gill < AIC_Sch){
       Selected_Model <- 'Cubic'
     } else if (AIC_Cub < AIC_Sch && AIC_Sch < AIC_Gill){
       Selected_Model <- 'Cubic'
     } else if (AIC_Cub > AIC_Sch && AIC_Sch < AIC_Gill){
       Selected_Model <- 'Schoolfield'
     } else if (AIC_Gill > AIC_Cub && AIC_Cub < AIC_Sch){
       Selected_Model <- 'Cubic'
     } else if (AIC_Gill > AIC_Cub && AIC_Cub > AIC_Sch){
       Selected_Model <- 'Schoolfield'
     }
    
     Results[i,] = c(uniqueID, uniqueTrait, B0_Cub, B1_Cub, B2_Cub, B3_Cub, logI0_Gill, I0_Gill, Ei_Gill, E_Sch, logB0_Sch, B0_Sch, Eh_Sch, Th_Sch, AIC_Cub, AIC_Gill, AIC_Sch, Selected_Model)
     
  }
  
  write.csv(Results, '../Results/Results.csv', row.names = FALSE)
}

TPCfit()

