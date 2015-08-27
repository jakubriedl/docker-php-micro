FROM phusion/baseimage

# Prepare basic deps
RUN apt-get update && apt-get install -y wget curl build-essential

# Prepare repositories
RUN echo "deb http://packages.dotdeb.org wheezy-php56 all" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://packages.dotdeb.org wheezy-php56 all" | tee -a /etc/apt/sources.list
RUN echo "deb http://apt.newrelic.com/debian/ newrelic non-free" | tee -a /etc/apt/sources.list
RUN wget http://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg
RUN wget https://download.newrelic.com/548C16BF.gpg && apt-key add 548C16BF.gpg
RUN apt-get update

# Install GIT
RUN apt-get install -y git

# Install PHP5.6
RUN apt-get install -y php5-cli php5-dev

# allow manipulation with ENV variables
RUN sed -i 's/variables_order = .*/variables_order = "EGPCS"/' /etc/php5/cli/php.ini
RUN sed -i 's/safe_mode_allowed_env_vars = .*/safe_mode_allowed_env_vars = ""/' /etc/php5/cli/php.ini

# Install PHP Curl
RUN apt-get install -y php5-curl

# Install Postgres Client
RUN apt-get install -y php5-pgsql

# Install Redis Client
RUN apt-get install -y php5-redis

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Instal MongoDB driver
RUN pecl install mongo
RUN echo "\nextension=mongo.so" > /etc/php5/cli/php.ini

# Install NewRelic
RUN apt-get install newrelic-php5
RUN newrelic-install install

RUN apt-get clean