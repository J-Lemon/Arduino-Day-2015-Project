local sun = {}

local visible, upper = false, true
local x, y, sx, sy = 450, 30, 3, 3

function sun.Update(status)
  if status == "1" then
    visible = true
  else
    visible = false
  end

  --Se il sole è visibile
  if visible == true then

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
      sy = sy+1
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
  return sy
end


return sun
