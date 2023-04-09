pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

cursorx,cursory = 1,1
cursor2x,cursor2y = 2,1

score = 0

function _init()
 grid = create_grid(8,8)
 eval_grid()
 redraw = true
 score = 0
end

redraw=true

function _update()
 if btnp(⬇️) then
  cursory += 1
  cursor2y += 1
  redraw=true
 elseif btnp(➡️) then
  cursorx += 1
  cursor2x += 1
  redraw=true
 elseif btnp(⬅️) then
  cursorx -= 1
  cursor2x -= 1
  redraw=true
 elseif btnp(⬆️) then
  cursory -= 1
  cursor2y -= 1
  redraw=true
 end
   
 if btnp(❎) then
  local t = grid[cursory][cursorx]
  grid[cursory][cursorx] = grid[cursor2y][cursor2x]
  grid[cursor2y][cursor2x] = t
 end   
 
 eval_grid()
    
end

function _draw()
 if redraw then
-- redraw=false
	 cls(7) 
  print("score:"..score, 1,1,1)
 
	 for y=1,#grid do
	  for x=1,#grid[y] do
	   spr(grid[y][x],x*9+30,y*9+30)
	   visited = get_fill(grid, y, x, 0, grid[y][x])
	   print(grid[y][x], x*9+32, y*9+32)
	  end
	 end
 end
 
 spr(16,cursorx*9+30,cursory*9+30)  
 spr(16,cursor2x*9+30,cursor2y*9+30)
end

colors = {0,1,2,3,4,7}

function create_grid(width, height)
 local grid = {}
 for row=1,height do
  grid[row] = {}
  for col=1,width do
   grid[row][col] = colors[ flr(rnd(#colors)) +1] 
  end
 end
 return grid
end




function eval_grid()
 redraw=true
 running = true
 while running do
  running = false
 -- printh("new", "fill.txt", true, true)
  for y=1,#grid do
   for x=1,#grid[y] do

    visited = get_fill(grid, y, x, 0, grid[y][x])
-- 		 printh(x..","..y..","..#visited, "fill.txt", false, true)
				if #visited >=3 then
				 score += #visited
				 running = true 
     for v in all(visited) do
      grid[v.row][v.col] = colors[flr(rnd(#colors))+1] 
--      printh("--"..v.col..","..v.row,
--      "fill.txt",false,true)
         
					end     
    end
   end
  end
 end
end








function get_fill(grid, start_row, start_col, new_color, initial_color)
 local queue = {{row = start_row, col = start_col}}  -- queue of cells to fill
 local visited = {}  -- table of visited cells
 local changed_cells = {}  -- list of cells that would be changed by the fill
 local num_rows = #grid
 local num_cols = #grid[1]
 local front, back = 1, 1

 while front <= back do
  local cell = queue[front]  -- dequeue a cell
  front = front + 1

  if not visited[cell.row * num_cols + cell.col] then
   visited[cell.row * num_cols + cell.col] = true
   if grid[cell.row][cell.col] == initial_color then
    -- add the current cell to the list of changed cells
    changed_cells[#changed_cells+1] = {row = cell.row, col = cell.col}

    -- enqueue neighboring cells
    if cell.row > 1 then
     back = back + 1
     queue[back] = {row = cell.row - 1, col = cell.col}  -- up
    end
    if cell.row < num_rows then
     back = back + 1
     queue[back] = {row = cell.row + 1, col = cell.col}  -- down
    end
    if cell.col > 1 then
     back = back + 1
     queue[back] = {row = cell.row, col = cell.col - 1}  -- left
    end
    if cell.col < num_cols then
     back = back + 1
     queue[back] = {row = cell.row, col = cell.col + 1}  -- right
    end
   end
  end
 end

 return changed_cells
end
__gfx__
111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff00000000
111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff00000000
111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff00000000
111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff00000000
111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff00000000
111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff00000000
111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff00000000
111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff00000000
66000066000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66000066000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010d0000370503a0513a0503c0513a0503705237052370503a0513a0503f0503c0523a0503705037051370503a0503c0503c0513d0503c0523a0513705035050350503a0503c0523705033051330503305233050
