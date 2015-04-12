# DO NOT EDIT 'install.R'; instead, edit 'install.R.in' and
# use 'rake' to generate 'install.R'.

url <- "http://bioconductor.org/packages/3.1/bioc"


if(!require(Matrix))
    biocLite("Matrix")

install.packages("BiocInstaller", repos=url)

