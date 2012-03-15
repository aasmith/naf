= naf

* http://github.com/aasmith/naf

== DESCRIPTION:

naf is not a framework.

== FEATURES/PROBLEMS:

* A demo web application that does not use a single over-arching framework.

Inspired by @unclebobmartin's keynote at Ruby Midwest 2011 [1], and the desire
for decoupling.

There are a few parts, some in a further stage of implementation than others.

DAO: Yes, a Data Access Object. Abstracts the database away. Defines a CRUD
interface around the marshaling of various objects. Concrete implementations
can be dead simple (MemoryDao), or simple (RelationalDao).

Business Objects/Models: No inheritance from a class that has a different
responsbility. Pure business logic lives here.

Services: The layer that pulls things together. Applies authorization, and
directs a workflow across mutliple models.

Controllers: The web-based frontend to a service. This is the only place the
internet and its various protocols should be mentioned. Like that one guy in
Office Space that takes the data from the customer and gives it to the
engineers. It just passes dumb data back and forth, no more. Controllers take
in data in various forms and emit JSON.

Views: Some fancy javascript layer that is still TBD. Ember, backbone, etc.
There may be some kind of schema description exposed [2], to make client
development less redundant. The goal is to avoid duplication of backend and
frontend models and validations, etc.

Tying together of various things, like routes for controllers, and decisions
about which type of DAO to use currently sit in config.ru.

1: http://confreaks.com/videos/759-rubymidwest2011-keynote-architecture-the-lost-years
2: http://json-schema.org/

== SYNOPSIS:

  FIX (code sample of usage)

== REQUIREMENTS:

* Sinatra
* Sequel if ORMing.

== INSTALL:

* FIX (sudo gem install, anything else)

== DEVELOPERS:

After checking out the source, run:

  $ rake newb

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.

== LICENSE:

(The MIT License)

Copyright (c) 2012 Andrew A. Smith

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
