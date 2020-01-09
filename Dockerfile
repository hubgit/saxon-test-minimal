FROM php:7-apache-buster

ARG DEBIAN_FRONTEND=noninteractive

ARG jdk='openjdk-11-jdk-headless'
ARG jvm='/usr/lib/jvm/java-11-openjdk-amd64'

# needed for openjdk-11-jdk-headless
RUN mkdir -p /usr/share/man/man1

## dependencies
RUN apt-get update
RUN apt-get install -y --no-install-recommends ${jdk} unzip

# edit this to use a different version of Saxon
# v1.1.2 works as expected
#ARG saxon='libsaxon-HEC-setup64-v1.1.2'
# v1.2.0 hangs in Apache at compileFromFile
ARG saxon='libsaxon-HEC-setup64-v1.2.0'

## fetch
RUN curl https://www.saxonica.com/saxon-c/${saxon}.zip --output saxon.zip
RUN unzip saxon.zip -d saxon

## install
RUN saxon/${saxon} -batch -dest /opt/saxon

## prepare
RUN ln -s /opt/saxon/libsaxonhec.so /usr/lib/
RUN ln -s /opt/saxon/rt /usr/lib/

## build
WORKDIR /opt/saxon/Saxon.C.API
RUN phpize
RUN ./configure --enable-saxon CPPFLAGS="-I${jvm}/include -I${jvm}/include/linux"
RUN make
RUN make install
RUN echo 'extension=saxon.so' > "$PHP_INI_DIR/conf.d/saxon.ini"
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

## add example files
COPY index.php example.xml example.xsl /var/www/html/
