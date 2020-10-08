This directory contains the client-side frontend for the application.

Note that the Docker container differs by environment:

- The development target runs a Vue dev server, which provides convenient
  facilities like code reloading.
- The production target runs an Nginx instance that serves the compiled Vue
  app.
