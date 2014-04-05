# Example app for elasticsearch_autocomplete gem

This is an example autocomplete app for [elasticsearch_autocomplete](https://github.com/leschenko/elasticsearch_autocomplete) gem

## Installation

Clone repository and setup application:

```bash
  git clone git://github.com/leschenko/example_elasticsearch_autocomplete.git
  cd example_elasticsearch_autocomplete
  bundle install
  bundle update
  rake db:create
  rake db:migrate
```

Setup autocomplete data and elasticsearch index:

```bash
  rake autocomplete
```

Run server

```bash
  bundle exec rails s
```

Visit `http://localhost:3000` and try it!
