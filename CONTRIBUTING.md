## Contributing to the DLVM Website

The DLVM website ([dlvm-team.github.io](http://dlvm-team.github.io)) is maintained by the DLVM team.

## Local Development

The DLVM website is built with [Jekyll](https://jekyllrb.com/).

You may make changes to the site like any other Jekyll website.
If you are unfamiliar with Jekyll, please visit the [Jekyll documentation](https://jekyllrb.com/docs/home/).

To run the site locally, do the following:

```sh
# Prerequisites: Ruby, RubyGems, make 
# Clone repository
git clone https://github.com/dlvm-team/dlvm-team.github.io.git dlvm-site
cd dlvm-site
# Install dependencies
make setup
# Serve site
make serve
```

To create posts/drafts more easily, consider making use of [`jekyll-compose`](https://github.com/jekyll/jekyll-compose):

```sh
# Install dependencies
make setup
# Run `jekyll-compose` commands
bundle exec jekyll post "Post Name"
bundle exec jekyll draft "Draft Name"
# More commands at https://github.com/jekyll/jekyll-compose
```
