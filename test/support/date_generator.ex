defmodule ThemoviedbAlexa.Test.Support.DateGenerator do
  use ExUnitProperties

  def gen_date_string do
    gen all year <- StreamData.integer(00..99),
            month <- StreamData.integer(1..12),
            day <- StreamData.integer(1..31),
            match?({:ok, _}, Date.from_erl({year, month, day})) do
      date = Date.from_erl!({year, month, day})
      date_iso = Date.to_iso8601(date)

      {date, date_iso}
    end
  end
end
