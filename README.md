My functions.

Just mucking about with GitHub really.

## My proposed setup

Where I want to get to is as follows.

On each PC that I use, I want to have a .some_sort_of_env file which would be environment specific. This will set up:

- $PoshHome (all of the subsequent variables would probably refer to $PoshHome)
- $GitFunctionsFolder
- $UnGitFunctionsFolder
- $WorkFolder
- $FirstFolder
- $ScriptsFolder
- $QuickReferenceFile

...and then a .matt file which is generic and will be in github and will

- call .some_sort_of_env_file
- load the functions in the two FunctionsFolder
- do any other generic stuff
- set common aliases

So stop using $RepositoryServer, unless just to save typing in .some_sort_of_env file.

Then I'd like to get the following into Github, and then clone into a standard set of folders:

- GitQuickRef.txt
- GitFunctionsFolder

(note: these aren't git functions, they're just functions which I'm storing in git)



