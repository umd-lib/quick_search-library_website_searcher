# quick_search-library_website_searcher

UMD Library Website searcher for NCSU Quick Search

## Installation

Include the searcher gem in your Gemfile:

```
gem 'quick_search-library_website_searcher'
```

Run bundle install:

```
bundle install
```

Include in your Search Results page

```
<%= render_module(@library_website, 'library_website') %>
```

## Configuration

The Library Website searcher requires configuration, such as specific URL to
use in retrieving search results. To set the configuration, create a
"config/searchers/" directory in your application (the "searchers" subdirectory
may need to be created), and copy the "config/library_website_config.yml" file
in this gem into it. Follow the instructions in the file to configure the
searcher.

Additional customizations can be done by editing the "config/locales/en.yml" file.
