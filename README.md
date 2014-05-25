run_analysis.R
===============

## Pros:

* Checks if files are in the ./UCI HAR Dataset/ dir (the one created after extracting the getdata_projectfiles_UCI HAR Dataset.zip file)
* Loads the data from X_test and X_train txt files
* Isolates the variables that calculate the mean() (not the meanFreq()) and the std() - 66 in total
* Names the variables according to the features.txt file in the zip
* Creates a tidy data set with the averages of the above isolated variables (all means and stds)
* Extracts the data set to a file called tidy.txt

## Cons:

* Its probably *not* the most elaborate coding you will see
* It might be rather slow on some computers :P - but not *too* slow and not on *every* computer

For any concerns, please feel free to contact me :)

Thanks!


