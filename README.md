# passman

A password manager for the command-line. GnuPG is used for encrypted the
password database.

*WARNING: This is a new project so consider this <strong>unstable</strong>.*

## Why?

This project is pretty similar to
[pass](http://www.zx2c4.com/projects/password-store/), but with some key
differences:

## No Leaky Abstraction

Pass stores passwords one per file, with a filename usually named after the
purpose of the password. You use this name to reference the password for
copying, etc. This means that if you use pass, there's probably a directory
listing that contains all of the services you use.

With passman passwords are stored in a database that's encrypted along with each
passwords identifier. This has the disadvantage that any operation that needs to
read the database require that you enter your GPG passphrase (for example
listing the identifier).

## Queryable Metadata

Pass uses the first line of the password file as the password the the subsequent
lines you can use for whatever you want.

Passman uses YAML for its database format. Fields can be added as needed. For
example, I store some passwords for some of my wife's accounts. For example, you
can ask passman for the password where the identifier is `bank` and the owner is
`wife`. You can also store additional data and like a checking account number.

## Commands

### Copy password to clipboard

`$ passman copy <query>`

The default configuration file uses `xclip` for managing the clipboard. You can
change the commands with configuration options `read_clipboard` and
`write_clipboard`. See configuration section below.

See the querying section below for details of the query parameter.

### Lists all identifier

`$ passman list`

### Lists all databases

`$ passman databases`

The database configured by the command-line optiosn and configuration file is
shown with an asterisk.

### Prints all records

`$ passman dump-all`

### Edit all records

`$ passman edit-all`

This dumps you into your $EDITOR with the decrypted YAML database. Currently
this makes a tempfile with the plain text database. There's probably a better
way to do this securely.

## Querying

Currently, there are two forms of querying that can be performed:

`gmail.com`

matches password records where the `identifier` is `gmail.com`. And:

`web/gmail.com`

matches password records where the `category` is `web` and the `identifier` is
`gmail.com`.

In the future, you'll be able to do more advanced queries using any defined metadata.

## Global Options

A few options are available globally and can be used for any command above.

### Default Database

`--database-default=name`

The name of a database to use (located in the `database-directory`). Do not include the
`.pdb.gpg` extension should not be included.

This option is available in the configuratin file in the `[database]` section as
`default`.

### Database Directory

`--database-directory=path`

The path to the database directory.

This option is available in the configuration file in the `[database]` section
as `directory`. It defaults to `~/.local/share/passman`.
