# DO NOT EDIT 'install.R'; instead, edit 'install.R.in' and
# use 'rake' to generate 'install.R'.

url <- "http://bioconductor.org/packages/3.1/bioc"



install.packages("BiocInstaller", repos=url)

if(!require(Matrix))
    BiocInstaller::biocLite("Matrix")
