# Ryan found problems with
#  J Infect Dis.-2015-Ogawa-infdis-jiv063,
#  Holsomback-2009-Bayou virus detected in non-Or.pdf,
#  Frances-2004-Occurrence of Ross River virus an.pdf. 


# Does work:  0043026620/Kaba-2010-Detection of hepatitis E virus in w1.pdf  - Article History on left side of page. Accepted 4 August 2009

# "../0857285937/Vasconcelos-2003-%5BYellow%20Fever%5D.xml" is in Portuguese.
#    Date is mar-abr, 2003.

if(FALSE) {
  i = file.info(list.files("..", full.names = TRUE))
  dirs = rownames(i)[i$isdir]
  pubs = lapply(dirs, function(x) try(getPublicationDate(list.files(x, pattern = "xml", full = TRUE))))  
  dirs[!err][ sapply(pubs[!err], length) == 0]
}



if(FALSE) {

# After matching.R

hasPDF = (!is.na(ms$PDF) & ms$PDF != "")
pdfs = unique(ms$PDF[hasPDF])
cleanPdfs = gsub("\\.pdf(;|$)", ".xml\\1", gsub("internal-pdf:/", path.expand(PDFDir), pdfs))
docs = strsplit(cleanPdfs, ";")
#docs = sapply(e, function(x) gsub("internal-pdf://", "", x))

#tt = table(unlist(docs))

ff = unique(unlist(docs))
ex = file.exists(ff)
table(ex)

dates = lapply(ff[ex], function(x) try(getPublicationDate(x)))
table(sapply(dates, is, "try-error")) # None.


b = ff[ex][ sapply(dates, length) == 0 ]
bpdf = gsub("\\.xml$", ".pdf", b)



################
# Older



PDFDir = "NewData_Feb2017/Zoo_02_02_2017 Copy.Data/PDF"
dirs = dirname(unlist(docs))
docDirs = list.files(PDFDir)
all(dirs %in% docDirs)
fdirs = sprintf("%s/%s", PDFDir, dirs)
xmls = sapply(fdirs, list.files, pattern = "xml$", full.names = TRUE)

xdocs = lapply(xmls, function(x) try(xmlParse(x)))
w = sapply(xdocs, is, 'try-error')

#xdocs[!w]
pd = lapply(xdocs[!w], getPublicationDate)

table(sapply(pd, length) == 0)

# The ones that  didn't match.
nodate = sapply(pd, length) == 0 
xmls[!w][nodate]

tmp = lapply(xdocs[!w][nodate], getPublicationDate)
i = (sapply(tmp, length) == 0)
f = xmls[!w][nodate][i]
gsub("\\.xml$", ".pdf", f)
}
