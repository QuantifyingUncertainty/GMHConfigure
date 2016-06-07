###Julia script called from inside amiconfig.sh to install the GMH julia package and its dependencies
###Can also be ran manually inside julia to install the GMH package

###Use when package is registered
#if Pkg.installed("GeneralizedMetropolisHastings") == nothing
#    Pkg.add("GeneralizedMetropolisHastings")
#end

###Use for unregistered package
try 
    Pkg.clone("git://github.com/QuantifyingUncertainty/GeneralizedMetropolisHastings.jl")'
catch
    println("GeneralizedMetropolisHastings already installed... continuing")
end

###Run an update for all packages
try
    Pkg.update()
catch
    println("=======================================================")
    println("Error during Pkg.update()... aborting")
    println("Please start julia and run Pkg.update() manually to fix")
    exit(1)
end

###Trigger an explicit build the Sundials package
try
    Pkg.build("Sundials")
catch
    println("================================================================")
    println("Error during Pkg.build(\"Sundials\")... aborting")
    println("Please start julia and run Pkg.build(\"Sundials\") manually to fix")
    exit(1)
end

###Trigger an explicit build the PyCall package
try
    Pkg.build("PyCall")
catch
    println("================================================================")
    println("Error during Pkg.build(\"PyCall\")... aborting")
    println("Please start julia and run Pkg.build(\"PyCall\") manually to fix")
    exit(1)
end

###Test the package
try
    Pkg.test("GeneralizedMetropolisHastings")
catch
    println("=============================================")
    println("Test errors for GeneralizedMetropolisHastings")
    println("Installation continues, but please fix later")
end
