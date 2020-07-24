defmodule HttpRequestParser do
  @moduledoc """
  Documentation for `HttpRequestParser`.
  """

  @doc """
  Assume the HTTP request is formed properly
  First line of the request is the start-line, there should be three words separated by spaces, the verb, path, and HTTP version (which we can ignore)
  ex:
  GET /index.php HTTP/1.1

  The next few lines are headers until a blank line is encountered
  Content-Type: text/html
  Host: php.net

  Anything after the head section is considered the body of the request
  """
  @spec parse(String.t()) :: Request.t()
  def parse(request_string) do
    %Request{}
  end

  @spec parse_headers([String.t()]) :: %{optional(String.t()) => String.t()}
  def parse_headers(headers) do
    %{}
  end
end
