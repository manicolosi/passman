# passman

This is a work in progress and it is probably not a good idea to use it yet.
Most of what's documented here is not working and is just a brain dump.

## Use cases

1. Storing passwords for different people (me vs spouse)
2. Storing passwords in different categories (web vs finance)
3. Storing passwords for different intents (personal vs work)

Numbers 1 and 2 can be solved with metadata fields (owner and category perhaps).
Three can also be sovled with a metadata field (intent or something like that)
or with a different database.

I like the database option, because it allows sharing the database with someone
else (like sharing the work database with whole team). Some configuration needs
to happens to allow specifying the default password.

## Configuration options

Use TOML for configuration.

1. Location of databases (defaults to XDG .local location)
2. External password generator
3. Default database
4. Copy tool
5. GnuPG stuff... (default recipient(s))

## Usage

### Initialize database

`$ passman init personal`

This also creates the configuration file specifying the default database to use
if it doesn't exist.

### Copy password to clipboard

`$ passman copy web/gmail.com`

Copy is the default operation and can be dropped:

`$ passman web/gmail.com`

Category is also optional (see querying section below):

`$ passman gmail.com`

### Print password to stdout

`$ passman print web/gmail.com`

### Print whole record to stdout

`$ passman dump web/gmail.com`

### Modify password
### Modify other fields and metadata
### Edit record in $EDITOR
### Edit all records in $EDITOR (dangerous)
### Create and edit a new record
### Create a new record and generate a password

## Password queries

The copy command requires that the query is unambiguous (only one record is
found).

The short-form query `<category>/<identifier>` can be used and is equivalent to
`category=<categroy> identifier=<identifier>`.

You can query on metadata:

Show me also passwords where I am the owner:

`owner=me`
