# Use the official Ruby image as the base image
FROM ruby:3.2.1

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    nodejs

# Install Rails dependencies
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.4.6
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Expose the Rails server port
EXPOSE 3000

# Set environment variables
ENV RAILS_ENV=development
ENV RAILS_SERVE_STATIC_FILES=true

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
