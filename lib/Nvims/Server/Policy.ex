defmodule Nvims.Server.Policy do
  use Corsica.Router,
    origins: ["http://localhost:8080"],
    allow_credentials: true,
    allow_headers: ["Content-Type"],
    max_age: 600

  resource "/api/*", origins: "*"
  resource "/*"
end
