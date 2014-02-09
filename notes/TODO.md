# TODO

## Password Queries

* Ability to query on any field or metadata
* Multiple query parameters
* Perform queries for list and dump-all commands

## Commands

* Modify password
  - Prompt for new one
  - Generate new one
* Modify record data
* Edit record data (in $EDITOR)
* Make `edit-all` less dangerous
  - Check syntax
  - Warn if records are removed
* Make `edit-all` more secure

## Testing

* Better way to inject input during command execution and ability to assert
  output during execution.
* Ability to use different GnuPG (i.e. without a passphrase)
