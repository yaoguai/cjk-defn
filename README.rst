cjk-defn
========

https://github.com/yaoguai/cjk-defn

cjk-defn is a command-line dictionary program for looking up definitions of
terms and phrases from the CJK languages (Chinese, Japanese, and Korean).
Unlike most other dictionaries, cjk-defn allows you to input entire lines of
text, and shows relevant definitions for all terms and phrases found.

cjk-defn is implemented in Python 3 and released under the MIT License.

Features include:

- Get definitions for longest matching terms
- Get definitions for each character
- Add as many dictionaries as you like
- Use as many dictionaries as you like
- Dictionary data in a SQLite database
- stdin-stdout I/O for flexibility
- Cross-platform console application
- Dictionary module can be imported

History / Why?
--------------

Around 2008-2009, I wanted a program like this, but none existed at that time.
All tools with similar functionality were Web-based, or proprietary, or were
limited to traditional dictionary lookups based on a single term. For someone
who preferred console programs, there were no applications for this. Therefore,
I had no choice but to make one myself.

After playing around with different formats, I wrote a program similar to this
one, also using a SQLite back-end. However, it was limited to only a few
pre-defined dictionaries. Because the application was ugly Python 2 and tied to
specific dictionaries, the program stayed private for years.

Coming back to the project recently, I wanted to make it general enough to be
useful to other people, and capable of using any number of dictionaries. After
kicking around a few designs, I went with a very simple database with just two
tables and a handful of fields. The new program has the flexibility to work
with any number of dictionaries. Since it has been generalized, it may be
useful to others who want such a dictionary program, and prefer the power and
flexibility of Unix tools.

Dictionaries
------------

By default, the dictionary program includes no dictionaries or definitions.
These are added by creating the SQLite database and inserting data into it. The
DICTIONARIES table contains basic dictionary metadata. The DEFINITIONS table is
for all dictionary definitions, and includes only a few standard fields.

For definitions, several free dictionaries are available, including those from
JMdict/EDICT (Japanese-English), and CC-CEDICT (Chinese-English). Tools from
the "edict-to-csv" software package may be helpful in converting dictionary
data for imports.

Installation
------------

To run this program, Python 3.x is required. Installation on a Unix-like
platform is advised, but Windows is possible too. If you must use Windows, then
Cygwin is the best environment.

To install the program, you can use the old::

    # python3 setup.py install

Or you can use pip, which is the new and better way.

Database Setup
--------------

After installing the program, the database should be initialized. The directory
for the database is located under the installation path in the following
location::

    $(PREFIX)/var/lib/cjk-defn/

In this directory, you can run the script "make-database" to create the
database. Only two tables are in the database, and these are as follows::

    DICTIONARIES:       <= Each entry is a dictionary
        DI_DICT         <= Dictionary ID (letters and numbers, no spaces)
        DI_SIGIL_S      <= 2-char ID for standard definitions (e.g. =Z)
        DI_SIGIL_C      <= 2-char ID for character definitions (e.g. -Z)
        DI_SHORT_DESCR  <= Very short description of the dictionary
        DI_LONG_DESCR   <= Long description, as much as you like

    DEFINITIONS:        <= Each entry is a dictionary definition
        DF_DICT         <= Dictionary ID
        DF_FORM1        <= Standard form of the term
        DF_FORM2        <= Other form of the term
        DF_ALT          <= Transliteration
        DF_DEFN         <= Full definition

Program Usage
-------------

By invoking the program with "-h" or "--help" flags, you can see usage
information, and also see which dictionaries are available in the database::

    $ cjk-defn -h

If we see that the dictionary "cedict" is available, then we can use it in the
following way::

    $ cjk-defn cedict

If we want to include character definitions, then we should add the suffix "/c"
to the end of the dictionary::

    $ cjk-defn cedict cedict/c

You can use any combination of dictionaries, in any order you like. If you want
to view definitions for an entire text, you could do something like the
following::

    $ cat mytext.txt | cjk-defn cedict cedict/c | less

If you want to define a default set of dictionaries, you can set an environment
variable, and then it is no longer necessary to specify the dictionaries when
invoking cjk-defn::

    $ CJK_DEFN_DICTS='cedict cedict/c'
    $ cat mytext.txt | cjk-defn | less

Documentation
-------------

A normal manual page is included with the software, cjk-defn(1), which covers
basic usage information.
