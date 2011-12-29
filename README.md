# Crontab Syntax Checker - Validate crontab entries

This Ruby code was written to validate an entry that will be used in [crontab](http://www.manpagez.com/man/5/crontab/ "man 5 crontab").

## Quick start examples

The crontab syntax checker is simple to use. These examples demonstrate three ways to quickly check that an entry is formatted correctly.

### Example 1 - Verify from a string

You may input your candidate crontab entry as a string to the verify_crontab_line() function:

```ruby
> require 'crontab_syntax_checker'
=> true 
> verify_crontab_line("5,35 */2 10-20,25-30 * 1-5 /foo/var | spam - > eggs.log")
=> "5,35 */2 10-20,25-30 * 1-5 /foo/var | spam - > eggs.log"
```

A string representation is returned upon success.  A RuntimeError is raised when the format is invalid.

### Example 2 - Verify from a hash

Another way to validate entries is by breaking up the crontab fields into a hash:

```ruby
> require 'crontab_syntax_checker'
=> true 
> verify_crontab_hash(
    :minute=>"5,35",
    :hour=>"*/2",
    :day=>"10-20,25-30",
    :month=>"*",
    :weekday=>"1-5",
    :command=>"/foo/var | spam - > eggs.log")
=> "5,35 */2 10-20,25-30 * 1-5 /foo/var | spam - > eggs.log"
```

A string representation is returned upon success.  A RuntimeError is raised when the format is invalid.

### Example 3 - Using an object

You may create a CrontabLine object directly and use setter methods for each field, which will be validated as they are set.  For example:

```ruby
> require 'crontab_syntax_checker'
=> true
> crontab = CrontabLine.new
=> #<CrontabLine:0x1005bf4b8
 @command="",
 @day=[#<CrontabAsterisk:0x1005bf328 @step=1>],
 @hour=[#<CrontabAsterisk:0x1005bf3a0 @step=1>],
 @minute=[#<CrontabAsterisk:0x1005bf3f0 @step=1>],
 @month=[#<CrontabAsterisk:0x1005bf2d8 @step=1>],
 @user=nil,
 @weekday=[#<CrontabAsterisk:0x1005bf288 @step=1>]>
> crontab.minute = "5,35"
=> "5,35"
> crontab.hour = "*/2"
=> "*/2"
> crontab.day = "10-20,25-30"
=> "10-20,25-30"
> crontab.month = "*"
=> "*"
> crontab.weekday = "1-5"
=> "1-5"
> crontab.command = "/foo/var | spam - > eggs.log"
=> "/foo/var | spam - > eggs.log"
> crontab.to_s
=> "5,35 */2 10-20,25-30 * 1-5 /foo/var | spam - > eggs.log"
```

When no RuntimeError is raised, it can be assumed that the crontab field is valid.

# Notes

Keep in mind that the verify functions or CrontabLine#to_s may not return exactly the same string as your input.  The output, though possibly not equal, should be equivalent crontab syntax.
* If a crontab list in a field contains an asterisk, with no stepping indicated, then the entire field will be converted to an asterisk.
* Extra white space in the command field will be truncated.
Feel free to use your own input in crontab after it has been validated.

This code follows the  man 5 crontab description of crontab files for validating entries.  Supported fields are asterisks, numbers, ranges, lists, and stepping (for ranges and asterisks).  Numbers must be within the valid range as per the man file.  Not supported are macro/named times.  See the man file for details on how crontab entries are formatted.

# Credits

Crontab Syntax Checker is maintained by [Stephen Sloan](https://github.com/SteveSJ76) and is funded by [BookRenter.com](http://www.bookrenter.com "BookRenter.com").

![BookRenter.com Logo](http://assets0.bookrenter.com/images/header/bookrenter_logo.gif "BookRenter.com")


# Copyright

Copyright (c) 2011 Stephen Slaon, Bookrenter.com. See LICENSE.txt for further details.