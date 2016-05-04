function blank-template { 
<#
.SYNOPSIS
  One-line description

.DESCRIPTION
  Longer description

.PARAMETER


.EXAMPLE
  Example of how to use this cmdlet

.EXAMPLE
  Another example of how to use this cmdlet
#>
  write-output "This is an intentionally useless function, that just serves to serve the about help topic"
}


function about_Markdown { 
<#
.SYNOPSIS
  Syntax for .md files

.DESCRIPTION

  # The largest heading (an <h1> tag)
  ## The second largest heading (an <h2> tag)
  > Blockquotes
  *italic* or _italic_
  **bold** or __bold__
  * Item (no spaces before the *) or
  - Item (no spaces before the -)
  1. Item 1
    1. A corollary to the above item.
    2. Yet another point to consider.
  2. Item 2
  3. Item 3
  `monospace` (backticks)
  ```` begin/end code block
  [Visit GitHub!](https://www.github.com).

#>
  write-output "This is an intentionally useless function, that just serves to serve the about help topic"
}



<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


