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

local clouds = {}

cloud_vel = 7

local alpha_rgb = 255

cloudimg = love.graphics.newImage("images/Cloud.gif")

cloud_left_x = 0-(cloudimg:getWidth( )*3)
cloud_right_x = 800

function clouds.Update(status)
  if status == true then
    if cloud_left_x < 370-(cloudimg:getWidth( )*3)  then
      cloud_left_x = cloud_left_x + cloud_vel
      cloud_right_x = cloud_right_x - cloud_vel

      --Diminuisci il colore generale
      alpha_rgb = alpha_rgb-3

      --Ritorna Falso se la pioggia non può ancora iniziare
      return false
    else
      --Ritorna True, la pioggia può iniziare
      return true
    end
    else
      if cloud_left_x > 0-(cloudimg:getWidth( )*3) then
        cloud_left_x = cloud_left_x - cloud_vel
        cloud_right_x = cloud_right_x + cloud_vel

        --Aumenta il colore generale
        alpha_rgb = alpha_rgb+3

        --Ritorna Falso, le nuole tornano indietro e la piaggia smette
        return false
      else
        --Ritorna True, la pioggia può continuare
        return false
    end
  end
  --Ritorna falso altrimenti
  return false
end

function clouds.Draw()
  love.graphics.draw(cloudimg, cloud_left_x,10,0, 4,3)
  love.graphics.draw(cloudimg, cloud_right_x,10,0, 4,3)
end

function clouds.GetAlphaRGB()
  return alpha_rgb
end

return clouds
