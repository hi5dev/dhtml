# Ruby 3.0.1+ on Alpine Linux 3.13.
FROM ruby:3.0-alpine3.13

# Where to publish the gem in the Docker image.
WORKDIR /src/dhtml

# Copy the files necessary to build the image.
COPY Gemfile /src/dhtml/Gemfile
COPY Gemfile.lock /src/dhtml/Gemfile.lock
COPY dhtml.gemspec /src/dhtml/dhtml.gemspec
COPY ./lib/dhtml/version.rb /src/dhtml/lib/dhtml/version.rb

# Download the latest Apline package lists.
RUN apk update --no-cache alpine-sdk

# Install NodeJS so the Opal tests can run.
RUN apk add --no-cache nodejs

# Update the system gems.
RUN gem update --system

# Install the same version of Bundler that was used to generate the lock file.
RUN gem install bundler:$(tail -n1 Gemfile.lock | awk '{$1=$1};1')

# Allow the gems to be installed in parallel with all available CPU cores.
RUN bundle config set --local jobs `nproc`

# Enable Ruby 3.0's JIT.
ENV RUBYOPT="--jit"

# Install all of the gems.
RUN bundle install
