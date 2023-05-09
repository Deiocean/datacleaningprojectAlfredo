# datacleaningprojectAlfredo
Data Cleaning Project

All the part before the ##Point 1 are related to the downloading, unzipping and reading of the tables, from the link given to the working folder.

#Point 1:
For point 1, a series of rbind was used to initially merge training and test datasets into dataSub, dataAct and dataFeat.
After assigning the variables names from the vector, the single merged tables were merged into dataFull after joining the names.

#Point 2:
In point 2 a subdataset of dataFeatName was created with the function grep() using the "string mean\\(\\)|std\\(\\)" as a pattern.
Subsequently, subDataFeatureName was used to create a vector of selectedNames and subsetting dataFull

#Point 3:
In point 3 the table activity_label was imported in R and used to name activities in dataFull via factor().

#Point 4:
In point 4, names were replaced one by one using the gsub() function.

#Point 5:
In point 5, a second dataset based on dataFull was create using the aggregate() function, was ordered as a tidy dataset and the printed in a file
using write.table().
