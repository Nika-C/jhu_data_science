### Peer-graded Assignment: Getting and Cleaning Data Course Project

The goal of the project was to obtain and tidy data from [ Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), which was published with metadata at UCL Machine Learning Repository. Processed data should be in more suitable form for further steps in data science workflow.

The dataset was built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

#### List of contents
 - `code_book.md`, file indicating features, describing calculated summaries, units etc,
 - `readme.md`, you are here.
 - `run_analysis.R`, project workhorse,
 - `subject_activity_mean_df.txt`, tidy dataset with summary stats.

#### What does the script do anyway?
 - it checks weather `data.table` and `dplyr` libraries are installed, if not the script will install them automatically,
 - above mentioned libraries are loaded into environment,
 - it checks weather there is archive `movement_data.zip` in working directory and if there is subfolder `UCI HAR Dataset` with extracted data, if not data will be downloaded and extracted,
 - subject identification, activity labels, measured features and measurements itself, for both train and test set, are loaded into environment with `fread` function from `data.table` package,
 -  subject identification, activity vector, feature labels and measurement parts,  are merged into one dataframe, which rules them all, 
 - only measurements with substrings `mean()` or `sd()` are filtered out,
 - feature labels are extended to be more understendable and comprehensive, also transformed to `snake_case` notation,
 -  features are summarised with mean point estimates across subjects and activities,
 - intermediary and summary datasets are exported to working directory.
