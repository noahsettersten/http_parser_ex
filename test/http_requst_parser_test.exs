defmodule HttpReqeustParserTest do
  use ExUnit.Case
  doctest HttpRequestParser

  test "parses a request without headers or body" do
    content = """
    GET / HTTP/1.1

    """

    assert %Request{
             method: "GET",
             path: "/",
             headers: %{},
             body: ""
           } = HttpRequestParser.parse(content)
  end

  test "parses a simple request" do
    content = """
    GET /index.php HTTP/1.1
    Content-Type: text/html

    """

    assert %Request{
             method: "GET",
             path: "/index.php",
             headers: %{"Content-Type" => "text/html"},
             body: ""
           } = HttpRequestParser.parse(content)
  end

  test "parses a request with multiple headers" do
    content = """
    POST /pizza/1 HTTP/1.1
    Content-Type: application/json
    Accept: application/json

    {toppings: ["pepperoni"], size: "lg"}\
    """

    assert %Request{
             method: "POST",
             path: "/pizza/1",
             headers: %{"Content-Type" => "application/json", "Accept" => "application/json"},
             body: ~S({toppings: ["pepperoni"], size: "lg"})
           } = HttpRequestParser.parse(content)
  end
end
