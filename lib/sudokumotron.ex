defmodule Sudokumotron do
  @moduledoc """
  Documentation for Sudokumotron.
  """

  @doc """
  Solve a sudoku puzzle
  """
  def solve(puzzle) do
    new_matches = fill_in_matches(puzzle)
    unless new_matches == puzzle do
      new_matches = solve(new_matches)
    end
    new_matches
  end

  def fill_in_matches(puzzle) do
    Enum.map(0..8, fn row ->
      Enum.map(0..8, fn col ->
        current_val = Enum.at(row_at(puzzle, row), col)
        if current_val == nil do
          possibilities = possibilities_for_cell(puzzle, col, row)
          if Enum.count(possibilities) == 1 do
            current_val = Enum.at(possibilities, 0)
          end
        end
        current_val
      end)
    end) |> List.flatten
  end

  def row_at(puzzle, row) do
    Enum.slice(puzzle, row * 9, 9)
  end

  def column_at(puzzle, column) do
    Enum.map((0..8), fn(row) -> cell_at(puzzle, column, row) end)
  end

  def cell_at(puzzle, column, row) do
    Enum.at(puzzle, column + (row * 9))
  end

  def box_at(puzzle, box) do
    box_row = div(box, 3) * 3
    box_col = rem(box, 3) * 3
    Enum.map((0..2), fn(row) ->
      row_at(puzzle, box_row + row) |> Enum.slice(box_col, 3)
    end) |> List.flatten
  end

  def all_numbers do
    [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def box_for_cell(col, row) do
    div(row, 3) * 3 + div(col, 3)
  end

  def possibilities_for_cell(puzzle, col, row) do
    all_numbers() --
      row_at(puzzle, row) ++
      column_at(puzzle, col) ++
      box_at(puzzle, box_for_cell(col, row))
  end
end
