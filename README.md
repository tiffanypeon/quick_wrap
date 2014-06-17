# QuickWrap

## Installation

Add this line to your application's Gemfile:

    gem 'QuickWrap'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install QuickWrap

## Usage

  1. Setting up your Configuration file:
    - set types of keys and options for keys
    - set endpoint
    - set authorization type and environment if necessary

  2. Understanding your connection and response setup
    -etag definition and examples
    -request headers/ multipart headers
    -different between body and header params
    -authorization tokens
    -environment setup (if it seems frequent)
    -faraday adapters and pros/cons
    -faraday body request types (eg. url encoded)

  3. Setting up your methods
    -GETs, with ids/special paths
    -POSTs, with params, etag matching, file uploads

  4. Setting up error handling - basic recs

  5. Parsing the response (method_missing thing here)

## Contributing

1. Fork it ( http://github.com/<my-github-username>/QuickWrap/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
