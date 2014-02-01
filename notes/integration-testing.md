# Integration Testing

## GnuPG

The following setup for GnuPG should be made before each test:

1. Unset any environmental variables that could interface (`GPG_AGENT_INFO`,
   etc).
2. Create a temporary directory and set the environmental variable `HOME` to it.
3. Generate new keys that will end up in the temporary `HOME`. See paragraphs
   below.

For cleaning up, we just need to remove the temporary home directory.

### Key Generation

GnuPG supports an option to generate keys in a batch mode with a paramater file
using `--gen-key` and `--batch` options. This information is documented in the
`doc/DETAILS` file in the GnuPG source.

An option exists in the parameter file exists to allow creation of keys without
a passphrase, `%no-protection`. The docs say this is mostly for regression
tests, so it looks like it will be useful here.

```
     %echo Generating a basic OpenPGP key
     Key-Type: DSA
     Key-Length: 1024
     Subkey-Type: ELG-E
     Subkey-Length: 1024
     Name-Real: Joe Tester
     Name-Comment: with stupid passphrase
     Name-Email: joe@foo.bar
     Expire-Date: 0
     Passphrase: abc
     %pubring foo.pub
     %secring foo.sec
     # Do a commit here, so that we can later print "done" :-)
     %commit
     %echo done
```

Used like so:

`gpg --batch --gen-key params`
