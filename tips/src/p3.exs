defmodule P3 do
  @moduledoc """
  Patch create function with little atom difference
  """
  whitespace = [:a, :b, :c]

  for codepoint <- whitespace do
    def do_trim_leading(unquote(codepoint), rest), do: IO.puts(rest)
  end
end

P3.do_trim_leading(:a, 2) |> IO.puts()
