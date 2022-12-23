require 'alias'
require 'utility'
require 'stages'
require 'update'
require 'draw'
require 'menu'
require 'hiscores'
require 'title'

bullets={}

score=0
shown_score=0
labels={}

t=0
tmult=1
timer=15*60
spawn_t=0

x=160+30*2*cos(pi/2)
y=100+30*2*sin(pi/2)

stage=1
circuit=1

function love.load()
    title=lg.newImage('INTEROBG.png')
end

function love.keypressed(key)
    if key=='escape' then
        if love.update==title_update then
            love.event.quit()
        elseif love.update==menu_update or love.update==register_update then
            love.update=title_update; love.draw=title_draw; bullets={}; spec={}; spawn_t=t+1
        elseif love.update~=wait then 
            love.update=wait; wt=120; shown_score=score; labels={} 
        end 
    end
end

-- implementations in draw.lua
function main_draw()
    bg_draw()

    for i,b in ipairs(bullets) do
        bullet_draw(b)
    end

    player_draw()

    overlay_draw()

    score_draw()

    special_draw()

    while love.timer.getTime()-dt<1/60 do
    end
end

-- implementations in update.lua
function main_update()
    dt=love.timer.getTime()
    
    player_update()

    stage_update()

    collision_update()

    score_update()

    t=t+tmult
end

-- implementations in menu.lua
function menu_draw()
    bg(0.1*255,0.1*255,0.1*255)

    menu_header_draw()

    thumbnail_draw()
    
    for i=0,3 do
        rect_draw(i)

        hiscore_draw(i)

        number_draw(i)
    end

    while love.timer.getTime()-dt<1/60 do
    end
end

-- implementations in menu.lua
function menu_update()
    dt=love.timer.getTime()

    circuit_preview()

    circuit_select()

    t=t+1
end

function title_draw()
    bg_draw()

    for i,b in ipairs(bullets) do
        bullet_draw(b)
    end

    if title_t then
        title_msg_draw(title_t)
    end

    lg.draw(title,title_x,200-120)

    while love.timer.getTime()-dt<1/60 do
    end
end

function title_update()
    dt=love.timer.getTime()

    if not lastscores then
        load_hiscores()
        load_progress()
    end

    stage14()

    title_select()

    title_anim()

    bullet_update()

    t=t+1
end

-- implementations in title.lua
function register_draw()
    bg(0.4*255,0.4*255,0.4*255)

    checkerboard_draw()

    shareware_msg_draw()

    register_msg_draw()

    while love.timer.getTime()-dt<1/60 do
    end
end

function register_update()
    dt=love.timer.getTime()

    t=t+1
end

love.update=title_update
love.draw=title_draw

DEBUG=false