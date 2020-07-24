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
    [meta | body] = String.split(request_string, "\n\n")
    [request_line | headers] = String.split(meta, "\n")
    [method, path, _] = String.split(request_line, " ")

    %Request{
      method: method,
      path: path,
      headers: parse_headers(headers),
      body: Enum.join(body)
    }
  end

  @spec parse_headers([String.t()]) :: %{optional(String.t()) => String.t()}
  def parse_headers(headers) do
    headers
    |> Enum.reduce(%{}, fn line, result ->
      [header_key | header_value] = String.split(line, ": ")
      Map.put(result, header_key, Enum.join(header_value))
    end)
  end
end
