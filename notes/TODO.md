# TODO

## Password Queries

* Ability to query on any field or metadata
* Multiple query parameters
* Perform queries for list and dump-all commands

## Commands

* Modify record data
* Modify password
  - Prompt for new one
  - Generate new one
* Print specified fields
* Combine print and dump into one command

## Querying

| Query          | Description |
| -------------- | ----------- |
| `text`         | partial match on identifier or category |
| `query query2` | ANDs queries |
| `cat/ident`    | partial match cat on category and ident on identifier |
| `field:value`  | partial match value on field |
| `field:=value` | whole match value on field |
| `field::regex` | regex match on field |

* Some inspiration: [Beets](http://beets.radbox.org/)

## Testing

* Ability to use different GnuPG keys (i.e. without a passphrase)

## Packaging

* RubyGems
* Arch PKGBUILD
* Debian and RPM packages
