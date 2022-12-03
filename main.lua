require 'alias'
require 'utility'
require 'stages'
require 'update'
require 'draw'
require 'menu'
require 'hiscores'

bullets={}

score=0
shown_score=0
labels={}

t=0
tmult=1
timer=15*60
lastspawn=0

x=160+30*2*cos(pi/2)
y=100+30*2*sin(pi/2)

stage=1
circuit=1

function love.keypressed(key)
    if key=='escape' then
        if love.update==menu_update then
            love.event.quit()
        elseif love.update~=wait then 
            love.update=wait; wt=120; shown_score=score; labels={} 
        end 
    end
end

function main_draw()
    bg(0.1*255,0.1*255,0.1*255)

    for i,b in ipairs(bullets) do
        bullet_draw(b)
    end

    player_draw()

    overlay_draw()

    score_draw()

    if stage==26 then
        bosscall_draw()
    end

    while love.timer.getTime()-dt<1/60 do
    end
end

function main_update()
    dt=love.timer.getTime()
    
    player_update()

    stage_update()

    collision_update()

    score_update()

    t=t+tmult
end

function menu_draw()
    bg(0.1*255,0.1*255,0.1*255)
    
    menu_header_draw()

    for i=0,3 do
        rect_draw(i)

        hiscore_draw(i)

        number_draw(i)
    end

    thumbnail_draw()
    
    while love.timer.getTime()-dt<1/60 do
    end
end

function menu_update()
    dt=love.timer.getTime()

    if t==0 then
        load_hiscores()
    end

    circuit_preview()

    circuit_select()

    t=t+1
end

love.update=menu_update
love.draw=menu_draw

DEBUG=false