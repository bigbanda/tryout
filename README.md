# README
All relevant SQL code and command line code necessary for Rohith Banda's tryout project for Mr. Jordan Lee Boyd-Graber's internship. This goes along with the write up and a pre-requisite is that the baseline QANTA system already exists on your machine.

Associated Write Up:

https://docs.google.com/document/d/1jS-Boe32R5YPvIoGUaAKdBh_hMonQqPawsW7f9fhTak/edit?usp=sharing

Baseline QANTA system:

https://github.com/Pinafore/qanta-codalab

# trainableformat_gettoken
This SQL file performs 3 steps. It creates the table "trainableformat", creates the function called "get_token", and inserts values into "trainableformat" by consolidating data from existing table data. This file is to be executed only after the full QuizDB dataset is downloaded. (Refer to associated write-up). NOTE: you may need to change the username according to how PostgreSQL is set up on your machine.

# postgres_to_json
This file contains 5 CLI commands that can be executed to convert the data from "trainableformat" to a JSON file. NOTE: Replace {absolute filepath} with the appropriate download filepath for your machine. Replace {username} with appropriate PostgreSQL username.

# References
For a complete list of references, take a look at the associated write-up.
