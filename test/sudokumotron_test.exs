defmodule SudokumotronTest do
  use ExUnit.Case
  doctest Sudokumotron

  def simple_puzzle do
    [
      nil, nil,   4, nil, nil, nil,   9,   2, nil,
      nil,   9, nil,   3,   2,   6,   5,   8, nil,
      nil, nil, nil,   4,   5, nil, nil, nil,   7,
        4,   1,   5, nil, nil,   3, nil,   6,   9,
        6,   7,   3, nil,   9, nil,   2,   4, nil,
        2,   8, nil,   6, nil, nil, nil,   5,   3,
        5, nil, nil, nil,   4,   1, nil, nil, nil,
      nil,   4,   1,   5,   6,   2, nil,   7, nil,
      nil,   2,   6, nil, nil, nil,   4, nil, nil,
    ]
  end

  def simple_puzzle_solution do
    [
        3,   5,   4,   1,   8,   7,   9,   2,   6,
        1,   9,   7,   3,   2,   6,   5,   8,   4,
        8,   6,   2,   4,   5,   9,   1,   3,   7,
        4,   1,   5,   2,   7,   3,   8,   6,   9,
        6,   7,   3,   8,   9,   5,   2,   4,   1,
        2,   8,   9,   6,   1,   4,   7,   5,   3,
        5,   3,   8,   7,   4,   1,   6,   9,   2,
        9,   4,   1,   5,   6,   2,   3,   7,   8,
        7,   2,   6,   9,   3,   8,   4,   1,   5,
    ]
  end

  test "solves a REALLY simple puzzle" do
    assert Sudokumotron.solve(simple_puzzle()) == simple_puzzle_solution()
  end

  test "solves a simple puzzle" do
    puzzle = [
      nil, nil, nil, nil, nil, nil, nil, nil, nil,
      nil, nil,   2, nil,   5, nil,   4, nil, nil,
      nil, nil, nil,   7,   9,   2, nil, nil, nil,
      nil, nil, nil, nil, nil, nil, nil, nil, nil,
      nil,   5, nil,   8, nil,   1, nil,   7, nil,
      nil,   8,   9,   4,   2,   5,   6,   1, nil,
      nil,   2,   6, nil, nil, nil,   9,   4, nil,
      nil,   7, nil, nil,   8, nil, nil,   2, nil,
        8, nil,   4,   2, nil,   6,   7, nil,   1,
    ]
    solution = [
      5, 1, 7, 6, 4, 3, 8, 9, 2,
      9, 3, 2, 1, 5, 8, 4, 6, 7,
      6, 4, 8, 7, 9, 2, 1, 3, 5,
      2, 6, 1, 3, 7, 9, 5, 8, 4,
      4, 5, 3, 8, 6, 1, 2, 7, 9,
      7, 8, 9, 4, 2, 5, 6, 1, 3,
      3, 2, 6, 5, 1, 7, 9, 4, 8,
      1, 7, 5, 9, 8, 4, 3, 2, 6,
      8, 9, 4, 2, 3, 6, 7, 5, 1
    ]
    assert Sudokumotron.solve(puzzle) == solution
  end

  describe "Sudokumotron.row_at/2" do
    test "can pull the first row" do
      assert Sudokumotron.row_at(simple_puzzle(), 0) == [nil, nil, 4, nil, nil, nil, 9, 2, nil]
    end

    test "can pull the last row" do
      assert Sudokumotron.row_at(simple_puzzle(), 8) == [nil, 2, 6, nil, nil, nil, 4, nil, nil]
    end
  end

  describe "Sudokumotron.column_at/2" do
    test "can pull the first column" do
      assert Sudokumotron.column_at(simple_puzzle(), 0) == [nil, nil, nil, 4, 6, 2, 5, nil, nil]
    end

    test "can pull the last column" do
      assert Sudokumotron.column_at(simple_puzzle(), 8) == [nil, nil, 7, 9, nil, 3, nil, nil, nil]
    end
  end

  describe "Sudokumotron.box_at/2" do
    test "can pull the first box" do
      assert Sudokumotron.box_at(simple_puzzle(), 0) == [nil, nil, 4, nil, 9, nil, nil, nil, nil]
    end

    test "can pull the last box" do
      assert Sudokumotron.box_at(simple_puzzle(), 8) == [nil, nil, nil, nil, 7, nil, 4, nil, nil]
    end
  end

  describe "Sudokumotron.box_for_cell" do
    test "can find the box for a cell in box 0" do
      assert Sudokumotron.box_for_cell(2, 2) == 0
    end
    test "can find the box for a cell in box 1" do
      assert Sudokumotron.box_for_cell(5, 2) == 1
    end
    test "can find the box for a cell in box 2" do
      assert Sudokumotron.box_for_cell(7, 2) == 2
    end
    test "can find the box for a cell in box 3" do
      assert Sudokumotron.box_for_cell(2, 5) == 3
    end
    test "can find the box for a cell in box 4" do
      assert Sudokumotron.box_for_cell(5, 5) == 4
    end
    test "can find the box for a cell in box 5" do
      assert Sudokumotron.box_for_cell(7, 5) == 5
    end
    test "can find the box for a cell in box 6" do
      assert Sudokumotron.box_for_cell(2, 8) == 6
    end
    test "can find the box for a cell in box 7" do
      assert Sudokumotron.box_for_cell(5, 8) == 7
    end
    test "can find the box for a cell in box 8" do
      assert Sudokumotron.box_for_cell(8, 8) == 8
    end
  end

  describe "Sudokumotron.possibilities_for_cell" do
    test "can find single possibilty when all other numbers in box" do
      assert Sudokumotron.possibilities_for_cell(simple_puzzle(), 2, 5) == [ 9 ]
    end
  end
end
