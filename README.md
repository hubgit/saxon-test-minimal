1. Run `docker build . -t saxon-test` to build the Docker image.
2. Run `docker run --rm saxon-test php /var/www/html/index.php` to execute the transformation via CLI (which succeeds).
3. Run `docker run --rm --publish 8080:80 saxon-test` to start the Apache web server and serve the transformation at http://127.0.0.1:8080/
