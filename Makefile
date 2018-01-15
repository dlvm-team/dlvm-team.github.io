# Set up website for development
setup:
	gem install bundler
	bundle install

# Publish site (push to master branch)
publish:
	bundle exec jekyll build
	./deploy.sh

# Serve website
serve:
	bundle exec jekyll serve --watch --trace

# Serve website, with drafts
serve-drafts:
	bundle exec jekyll serve --watch --trace --drafts
