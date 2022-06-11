defmodule P4 do
  @moduledoc """
  Explore the lexer topic provide by elixir
  """
  def lexer(str) do
    parse(str, "", [])
  end

  def parse("", buffer, acc) do
    [buffer | acc]
  end

  def parse("=" <> rest, buffer, _) do
    parse(rest, buffer, [:==])
  end

  def parse(">" <> rest, buffer, _) do
    parse(rest, buffer, [:>])
  end

  def parse("<" <> rest, buffer, _) do
    parse(rest, buffer, [:<])
  end

  def parse(<<" ", rest::binary>>, buffer, acc) do
    parse(rest, buffer, acc)
  end

  def parse(<<first, rest::binary>>, buffer, acc) do
    parse(rest, <<buffer::binary, first>>, renew(acc))
  end

  defp renew(acc) do
    case acc do
      [] -> [:==]
      _ -> acc
    end
  end
end

ExUnit.start()

defmodule Test do
  use ExUnit.Case, async: true

  test "lexer test" do
    assert P4.lexer("=1.1.1") == ["1.1.1", :==]
    assert P4.lexer("1.1.1") == ["1.1.1", :==]
    assert P4.lexer(" 1.1.1") == ["1.1.1", :==]
    assert P4.lexer("= 1.1.1") == ["1.1.1", :==]
    assert P4.lexer(" = 1.1.1") == ["1.1.1", :==]
    assert P4.lexer(">1.1.1") == ["1.1.1", :>]
    assert P4.lexer("<1.1.1") == ["1.1.1", :<]
  end
end
