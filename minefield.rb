require_relative "cell"

class Minefield
  attr_reader :row_count, :column_count
  attr_accessor :grid

  def initialize(row_count, column_count, mine_count)
    @column_count = column_count
    @row_count = row_count

    @grid = Array.new(column_count){Array.new(row_count).map {Cell.new}}
    initialize_grid_with_bombs(mine_count)
  end

  def initialize_grid_with_bombs(mine_count)
    while mine_count > 0
      x = rand(row_count-1)
      y = rand(column_count-1)

      grid[x][y].fill = 1

      mine_count-= 1
    end

  end
  # Return true if the cell been uncovered, false otherwise.
  def cell_cleared?(row, col)
    grid[row][col].uncovered

  end

  # Uncover the given cell. If there are no adjacent mines to this cell
  # it should also clear any adjacent cells as well. This is the action
  # when the player clicks on the cell.
  def clear(row, col)

    # will not clear a cell that has already been cleared in recursive call
    if cell_cleared?(row, col) == false
      grid[row][col].uncovered = true

      if adjacent_mines(row, col) == 0 && grid[row][col].fill == 0
        clear(row+1, col) if (row + 1) < row_count
        clear(row-1,col) if (row - 1) >= 0
        clear(row,col+1) if (col + 1) < column_count
        clear(row,col-1) if (col -1) >= 0
        clear(row+1,col+1) if (row + 1) < row_count && (col + 1) < column_count
        clear(row+1,col-1) if (row + 1) < row_count && (col -1) >= 0
        clear(row-1,col+1) if (row - 1) >= 0 && (col + 1) < column_count
        clear(row-1,col-1) if (row - 1) >= 0 && (col -1) >= 0
      end
    end
  end

  # Check if any cells have been uncovered that also contained a mine. This is
  # the condition used to see if the player has lost the game.
  def any_mines_detonated?
    grid.each do |row|
      row.each do |cell|
        if cell.fill == 1 && cell.uncovered == true
          return true
        end
      end
    end

    false
  end

  # Check if all cells that don't have mines have been uncovered. This is the
  # condition used to see if the player has won the game.
  def all_cells_cleared?
    grid.each do |row|
      row.each do |cell|
        if cell.uncovered == false && cell.fill == 0
          return false
        end
      end
    end

    true
  end

  # Returns the number of mines that are surrounding this cell (maximum of 8).
  def adjacent_mines(row, col)

    count = 0

    count += 1 if (row + 1) < row_count && grid[row+1][col].fill == 1
    count += 1 if (row - 1) >= 0 && grid[row-1][col].fill == 1
    count += 1 if (col + 1) < column_count && grid[row][col+1].fill == 1
    count += 1 if (col -1) >= 0 && grid[row][col-1].fill == 1
    count += 1 if (row + 1) < row_count && (col + 1) < column_count && grid[row+1][col+1].fill == 1
    count += 1 if (row + 1) < row_count && (col -1) >= 0 && grid[row+1][col-1].fill == 1
    count += 1 if (row - 1) >= 0 && (col + 1) < column_count && grid[row-1][col+1].fill == 1
    count += 1 if (row - 1) >= 0 && (col -1) >= 0 && grid[row-1][col-1].fill == 1

    return count
  end

  # Returns true if the given cell contains a mine, false otherwise.
  def contains_mine?(row, col)
    grid[row][col].fill == 1
  end
end
