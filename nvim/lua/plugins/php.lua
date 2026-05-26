return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              files = {
                maxSize = 5000000,
              },
              environment = {
                phpVersion = "8.2",
              },
              stubs = {
                "apache", "bcmath", "bz2", "calendar", "Core", "ctype",
                "curl", "date", "dba", "dom", "enchant", "exif", "FFI",
                "fileinfo", "filter", "fpm", "ftp", "gd", "gettext", "gmp",
                "hash", "iconv", "imap", "intl", "json", "ldap", "libxml",
                "mbstring", "mcrypt", "meta", "mysqli", "oci8", "odbc",
                "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql",
                "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix",
                "pspell", "readline", "Reflection", "regex", "session",
                "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium",
                "SPL", "sqlite3", "standard", "superglobals", "sysvmsg",
                "sysvsem", "sysvshm", "tokenizer", "xml", "xmlreader",
                "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib",
              },
            },
          },
        },
      },
    },
  },
}
