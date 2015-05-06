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

serial = require("serial")
sun = require ("Sun/Sun")
rain = require ("Rain/Rain")
clouds = require("Clouds/Clouds")

rain_reset_status = false
cloud_status = false

--Variabile Sensore
sensor_status = true

function love.load()
	--Setta il tempo minimo di aggiornamento dello schermo
	min_dt = 1/25
	next_time = love.timer.getMicroTime()
	
	--Timer per gli imput del sensore
	wait_time = love.timer.getMicroTime()
	
	--Carica le immagini
	sunimg = love.graphics.newImage("images/angry_sun_.png")
	mario = love.graphics.newImage("images/Mario.png")
	marioup = love.graphics.newImage("images/MarioUp.png")
	backgroundimg = love.graphics.newImage("images/background.png")

	--Setta il numero di gocce di pioggia
	rain.Populate(1000,10,10)

	--Inizializza L'arduino
	port, msg = serial.open("/dev/ttyUSB3", 9600)
		if port==-1 then
			error("Unable to open port - error: "..msg)
		end
end

function love.update()

	c,d = math.modf(wait_time)
	
	--Aggiorna il timer per l'aggiornamento dello schermo
	next_time = next_time + min_dt

	--Aggiorna il sole
	sun.Update(sensor_status)

	cloud_status = clouds.Update(sensor_status)

	--Aggiorna le nuvole
	if cloud_status == true and  sensor_status then
		--Aggiorna la pioggia
		rain.Update()
		rain_reset_status = false
	end

	--byte, check_variable = serial.readbytes(port, 1)
	if byte ~= -1 then
		if check_variable == "1" then
			sensor_status = false
		else
			sensor_status = true  
		end
	end
end

function love.draw()

	--Setta l'alpha dello schermo
	love.graphics.setColor( clouds.GetAlphaRGB(), clouds.GetAlphaRGB(), clouds.GetAlphaRGB(), 255 )

	--Setta il fondale ad azzurro se il sensore non è coperto
	if sensor_status == false then
		love.graphics.setBackgroundColor( 89, 156, 231)
	else
	--Setta il fondale a grigio se il sensore è coperto
		love.graphics.setBackgroundColor( 156, 156, 156)
	end

	--Disegna lo scenario
	love.graphics.draw(backgroundimg,0,101)
	
	--Disegna il sole
	love.graphics.draw(sunimg, sun.GetX(), sun.GetY(), 0, sun.GetW(), sun.GetH() )
	if cloud_status == true then
		love.graphics.draw(mario,400,453)
		rain.Draw()
	else
		love.graphics.draw(marioup,400,454)
	end
	clouds.Draw()

	--Aspetta fino al prossimo aggiornamento
	local cur_time = love.timer.getMicroTime()
	if next_time <= cur_time then
		next_time = cur_time
	else
		love.timer.sleep(next_time - cur_time)
	end
end
