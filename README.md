# Crontab Syntax Checker - Validate crontab entries

This Ruby code was written to validate an entry that will be used in crontab.  

## Quick start examples

Crontab syntax checker is simple to use, which these examples demonstrate.  There are three ways to quickly check that an entry is formatted correctly.

### Example 1 - Verify from a string

You may input your candidate crontab entry as a string to the verify_crontab_line() function:

```ruby
> require 'crontab_syntax_checker'
=> true 
> verify_crontab_line("* * * * * foo")
=> "* * * * * foo"
```

A string representation is returned upon success.  A RuntimeError is raised when the format is invalid.

### Example 2 - Verify from a hash

Another way to validate entries is by breaking up the crontab fields into a hash:

```ruby
> require 'crontab_syntax_checker'
=> true 
> verify_crontab_hash(:minute=>"*", :hour=>"*", :day=>"*", :month=>"*",  :weekday=>"*", :command=>"foo")
=> "* * * * * foo"
```

The verify_crontab_hash() function should be easy to use by other scripts.  

Additionally, you may use the CrontabLine class directly and use setter methods for each field, which will be validated as they are set.  When no RuntimeError is raised, it can be assumed that the crontab field is valid.  For example:

crontab = CrontabLine.new
crontab.minute = "*"
crontab.hour = "*"
crontab.day = "*"
crontab.month = "*"
crontab.weekday = "*"
crontab.command = "foo"
crontab.to_s

Note that the verify functions or CrontabLine::to_s may not return exactly the same string as your input.  The output, though possibly different, should be functionally equivalent.  Extra white space in the command field will be truncated.  Also, if a list in a field contains an asterisk, with no stepping indicated, then the entire field will be converted to an asterisk.  Feel free to use your input in crontab after it has been validated.

This code follows the  man 5 crontab description of crontab files for validating entries.  Supported fields are asterisks, numbers, ranges, lists, and stepping (for ranges and asterisks).  Numbers must be within the valid range as per the man file.  Not supported are macro/named times.  See the man file for details on how crontab entries are formatted.

# Credits

Crontab Syntax Checker is maintained by [Stephen Sloan](https://github.com/SteveSJ76) and is funded by [BookRenter.com](http://www.bookrenter.com "BookRenter.com").

![BookRenter.com Logo](http://assets0.bookrenter.com/images/header/bookrenter_logo.gif "BookRenter.com")


# Copyright

Copyright (c) 2011 Stephen Slaon, Bookrenter.com. See LICENSE.txt for further details.