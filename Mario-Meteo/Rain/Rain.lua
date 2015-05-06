--[[
Copyright (C) 2015, Pasquale De Rose aka J-Lemon <james.lemon992@gmail.com>
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.]]--

local rain = {}

local drops = {}

drops_num = 100
drops_start = 10
drops_to_add = 1
drops_vel = 10

dropimg = love.graphics.newImage("images/Drop.png")

function rain.Populate(dropnum, dropstart, dropadd)
  drops_num = dropnum
  drops_start = dropstart
  drops_to_add = dropadd
  for i=1, drops_start do
    drop = {math.random(800), math.random(60,80)}
    drops[i] = drop
  end
end

function rain.Update()
  --Aggiorna la posizione delle gocce
  for i=1, drops_start do
    drops[i][2] = drops[i][2]+drops_vel
    if drops[i][2] >= 600 then
      drops[i][2] = math.random(60,95)
    end
  end

  --Aumenta il numero delle Gocce
  if drops_num>drops_start then
    --Controlla il reale numero di gocce da aggiungere
    x = 0
    if drops_num - drops_start < drops_to_add then
      x = drops_num - drops_start
    else
      x = drops_to_add
    end

    --Aggiungi le gocce all'array
    for i=drops_start, drops_start+x do
      drop = {math.random(800), math.random(60,80)}
      drops[i] = drop
    end
    --Aggiungi le gocce aggiunte al numero di gocce attuali
    drops_start = drops_start+x
  end
end

function rain.Draw()
  for i=1, drops_start do
    love.graphics.draw(dropimg, drops[i][1], drops[i][2])
  end
end

return rain
