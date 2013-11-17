Take a look at hn.rb for all the UNTESTED magic. Sorry, but I didn't originally write this with big plans. Still trying to form a testing habit. There is plenty of room for refactoring here.


Getting Started
---------------

$ gem install bunder

$ gem install foreman

Start Postgres

$ bundle

$ rake db:setup

I am using a .env for ENV variables and Foreman to start the party via a Procfile.

$ foreman start


Example .env file

```

RACK_ENV=development
PORT=5050

SECRET_TOKEN=REALLY-long-STRING

REDISTOGO_URL=redis://localhost:6379

```

$ foreman run rails console

\> Hn.scrape_hn

<http://localhost:5050/hn?version=v1>
