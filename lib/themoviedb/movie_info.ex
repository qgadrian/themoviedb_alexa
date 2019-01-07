defmodule Themoviedb.MovieInfo do
  @type t :: %__MODULE__{
          name: String.t(),
          rating: float,
          release_date: Date.t()
        }

  defstruct [:name, :rating, :release_date]
end
