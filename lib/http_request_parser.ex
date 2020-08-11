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
    [head, body] = String.split(request_string, "\n\n", parts: 2)
    [request | headers] = String.split(head, "\n")
    [method, path, _] = String.split(request, " ")

    %Request{
      method: method,
      path: path,
      headers: parse_headers(headers),
      body: body
    }
  end

  @spec parse_headers([String.t()]) :: %{optional(String.t()) => String.t()}
  def parse_headers(headers) do
    parsed = Enum.flat_map(headers, fn(h) ->
      String.split(h, ": ")
    end)

    parsed
    |> Enum.chunk_every(2)
    |> Map.new(fn [k, v] -> {k, v} end)
  end
end
