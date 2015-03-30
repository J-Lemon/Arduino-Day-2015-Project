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
