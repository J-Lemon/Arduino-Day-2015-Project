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

local sun = {}

local visible, upper = false, true
local x, y, sx, sy = 450, 30, 3, 3

function sun.Update(status)

  --Se il sole è visibile
  if status == false then

    --Ingrandisci il sole se non è grande abbastanza
    if sx < 3 then
      sx = sx+1
      sy = sy+1
    end

    --Sposta il sole in basso, altrimenti se è arrivato alla distanza massima (40 pixel) torna su
    if upper == false then
      y= y+1
      if y == 30 then
        upper = true
      end
    else
      y= y-1
      if y == 10 then
        upper = false
      end
    end

  --Se il sole non è visibile
  else

    --Diminuisci la grandezza del sole
    if sx > 1 then
      sx = sx-1
      sy = sy-1
    end
  end
end

function sun.GetX()
  return x
end

function sun.GetY()
  return y
end

function sun.GetW()
	return sx
end

function sun.GetH()
	return sx
end
return sun
