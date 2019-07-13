.DEFAULT_GOAL := rspec

.PHONY: rspec
rspec: 
	bundle install
	bundle exec parallel_rspec spec/

.PHONY: rubocop
rubocop: 
	bundle exec rubocop -a

.PHONY: generate_sitemaps
generate_sitemaps:
	bundle exec ruby ./scripts/generate_sitemaps.rb

.PHONY: generate_rss
generate_rss:
	bundle exec ruby ./scripts/generate_rss.rb

.PHONY: upload_to_s3
upload_to_s3:
	bundle exec ruby ./scripts/upload_to_s3.rb
