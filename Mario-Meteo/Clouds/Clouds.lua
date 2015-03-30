local clouds = {}

cloud_vel = 7

local alpha_rgb = 255


cloudimg = love.graphics.newImage("images/Cloud.gif")

cloud_left_x = 0-(cloudimg:getWidth( )*3)
cloud_right_x = 800

function clouds.Update(status)
  if status == 1 then
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
        return true
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
