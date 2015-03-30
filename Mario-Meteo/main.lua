serial = require("serial")
sun = require ("Sun/Sun")
rain = require ("Rain/Rain")
clouds = require("Clouds/Clouds")

act_variable = ""

rain_reset_status = false
cloud_status = false

--Variabile Sensore
sensor_status = true

function love.load()
	--Setta il tempo minimo di aggiornamento dello schermo
	min_dt = 1/25
	next_time = love.timer.getMicroTime()

	--Carica le immagini
	sunimg = love.graphics.newImage("images/angry_sun_.png")
	mario = love.graphics.newImage("images/mario-luigi.png")
	backgroundimg = love.graphics.newImage("images/background.png")

	--Setta il numero di gocce di pioggia
	rain.Populate(1000,10,10)

	--Inizializza L'arduino
	--port, msg = serial.open("/dev/ttyUSB0", 9600)
		--if port==-1 then
			--error("Unable to open port - error: "..msg)
		--end
end

function love.update()
	--Aggiorna il timer per l'aggiornamento dello schermo
	next_time = next_time + min_dt

	--Aggiorna il sole
	sun.Update("1")

	cloud_status = clouds.Update(1)

	--Aggiorna le nuvole
	if cloud_status == true then
		--Aggiorna la pioggia
		rain.Update()
		rain_reset_status = false
	elseif cloud_past_status == false then
		rain.Populate(1000,10,10)
		rain_reset_status = true
	end


	--byte, check_variable = serial.readbytes(port, 3)
	--if byte ~= -1 then
		--act_variable = check_variable
	--end
	--print(byte)
	--print(check_variable)
end

function love.draw()

	--Setta il fondale ad azzurro
	if sensor_status == true then
		love.graphics.setBackgroundColor( 89, 156, 231)
	else
		love.graphics.setBackgroundColor( 156, 156, 156)
	end

	love.graphics.setColor( clouds.GetAlphaRGB(), clouds.GetAlphaRGB(), clouds.GetAlphaRGB(), 255 )

	love.graphics.draw(backgroundimg,0,101)
	love.graphics.draw(sunimg, sun.GetX(), sun.GetY(), 0, sun.GetW(), sun.GetH() )
	if cloud_status == true then
		rain.Draw()
	end
	clouds.Draw()


	love.graphics.print(act_variable, 400, 300)

	--Aspetta fino al prossimo aggiornamento
	local cur_time = love.timer.getMicroTime()
   if next_time <= cur_time then
      next_time = cur_time
      return
   end
	love.timer.sleep(next_time - cur_time)
end
