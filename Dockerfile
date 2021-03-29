FROM ruby:latest
LABEL maintainer lindynetech@gmail.com

RUN gem install rest-client sinatra json thin

COPY ./book-library.rb /opt/book-library.rb

EXPOSE 8080

CMD ["ruby", "/opt/book-library.rb", "-p", "8080"]

