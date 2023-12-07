FROM ruby:3.2-alpine
WORKDIR /
COPY server.rb /
CMD ["ruby", "/server.rb"]
