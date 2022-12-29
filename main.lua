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
    sparkle1=lg.newImage('sparkle1.png')
    sparkle2=lg.newImage('sparkle2.png')
    sparkle3=lg.newImage('sparkle3.png')
end

function love.keypressed(key)
    if key=='escape' then
        if love.update==title_update then
            love.event.quit()
        elseif love.update==help_update then
            helpscr=1; love.update=title_update; love.draw=title_draw
        elseif love.update==menu_update or love.update==register_update then
            love.update=title_update; love.draw=title_draw; bullets={}; spec={}; spawn_t=t+1
        elseif love.update==victory_update then
            love.update=menu_update; love.draw=menu_draw; bullets={}; spec={}; spawn_t=t+1
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

    spawner_draw()

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

-- implementations in title.lua
function title_draw()
    bg_draw()

    for i,b in ipairs(bullets) do
        bullet_draw(b)
    end

    spawner_draw()

    if title_t then
        title_msg_draw(title_t)
    end

    lg.draw(title,title_x,200-120)

    version_msg_draw()

    while love.timer.getTime()-dt<1/60 do
    end
end

-- implementations in title.lua
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
    checkerboard_draw()

    shareware_msg_draw('support shareware?!')

    register_msg_draw(register_lines)

    while love.timer.getTime()-dt<1/60 do
    end
end

function register_update()
    dt=love.timer.getTime()

    t=t+1
end

function help_draw()
    if helpscr==1 then

    bg(0.3*255,0.3*255,0.3*255)
    fg(0.5*255,0.5*255,0.5*255)
    for i=16,200,48 do
        rect('fill',0,i,320,24)
    end

    header_draw('Page 1: Gameplay elements')

    local ox,oy=24,16

    fg(0.2*255,0.2*255,0.2*255)
    rect('fill',16+1+ox,16+1-3+oy,32-2,32-2)
    fg(0.4*255,0.8*255,0.4*255)
    rect('line',16+ox,16-3+oy,32,32)
    player_draw(16+8+8-4+1+ox,16+8+8-4+1-3+oy,true)

    local msg='This is you. Arrow keys to move and'
    fg(0.2*255,0.2*255,0.2*255)
    lg.print(msg,16+32+4+1+ox,16+4+1+oy)
    fg(0.8*255,0.8*255,0.8*255)
    lg.print(msg,16+32+4+ox,16+4+oy)
    local msg='Z/X to slow down/speed up time.'
    fg(0.2*255,0.2*255,0.2*255)
    lg.print(msg,16+32+4+1+ox,16+4+1+10+oy)
    fg(0.8*255,0.8*255,0.8*255)
    lg.print(msg,16+32+4+ox,16+4+10+oy)

    fg(0.2*255,0.2*255,0.2*255)
    rect('fill',16+1+ox,16+1-3+36+oy,32-2,32-2)
    fg(0.4*255,0.8*255,0.4*255)
    rect('line',16+ox,16-3+36+oy,32,32)
    bullet_draw({x=16+8+8-4+1+ox,y=16+8+8-4+1-3+36+oy})

    local msg='This is a bullet. Don\'t touch it, but'
    fg(0.2*255,0.2*255,0.2*255)
    lg.print(msg,16+32+4+1+ox,16+4+1+36+oy)
    fg(0.8*255,0.8*255,0.8*255)
    lg.print(msg,16+32+4+ox,16+4+36+oy)
    local msg='stay just close enough to gain score.'
    fg(0.2*255,0.2*255,0.2*255)
    lg.print(msg,16+32+4+1+ox,16+4+1+10+36+oy)
    fg(0.8*255,0.8*255,0.8*255)
    lg.print(msg,16+32+4+ox,16+4+10+36+oy)

    fg(0.2*255,0.2*255,0.2*255)
    rect('fill',16+1+ox,16+1-3+36+36+oy,32-2,32-2)
    fg(0.4*255,0.8*255,0.4*255)
    rect('line',16+ox,16-3+36+36+oy,32,32)
    local img
    if t%12<4 then img=sparkle1
    elseif t%12<8 then img=sparkle2
    else img=sparkle3 end

    lg.draw(img,16+8+8-4+1-4+ox,16+8+8-4+1-3+36+36-4+oy)

    local msg='This is a bullet spawner.'
    fg(0.2*255,0.2*255,0.2*255)
    lg.print(msg,16+32+4+1+ox,16+4+1+36+36+5+oy)
    fg(0.8*255,0.8*255,0.8*255)
    lg.print(msg,16+32+4+ox,16+4+36+36+5+oy)

    fg(0.2*255,0.2*255,0.2*255)
    rect('fill',16+1+ox,16+1-3+36+36+36+oy,32-2,32-2)
    fg(0.4*255,0.8*255,0.4*255)
    rect('line',16+ox,16-3+36+36+36+oy,32,32)

    fg(0.8*255,0.4*255,0.4*255)
    lg.print('100',16+8+8-4+1-4-1+ox,16+8+8-4+1-3+36+36+36-2+oy)

    local msg='This is a score label. Once it hits the'
    fg(0.2*255,0.2*255,0.2*255)
    lg.print(msg,16+32+4+1+ox,16+4+1+36+36+36+oy)
    fg(0.8*255,0.8*255,0.8*255)
    lg.print(msg,16+32+4+ox,16+4+36+36+36+oy)
    local msg='score counter, you get that many points.'
    fg(0.2*255,0.2*255,0.2*255)
    lg.print(msg,16+32+4+1+ox,16+4+1+36+36+36+10+oy)
    fg(0.8*255,0.8*255,0.8*255)
    lg.print(msg,16+32+4+ox,16+4+36+36+36+10+oy)

    end

    if helpscr==2 then
        bg(0.2*255,0.6*255,0.2*255)
        fg(0.4*255,0.8*255,0.4*255)
        for i=16,200,48 do
            rect('fill',0,i,320,24)
        end

        header_draw('Page 2: Game progression')
    end

    if helpscr==3 then
        bg(0.2*255,0.2*255,0.6*255)
        fg(0.4*255,0.4*255,0.8*255)
        for i=16,200,48 do
            rect('fill',0,i,320,24)
        end

        header_draw('Page 3: Scoring')
    end

    if helpscr==4 then
        bg(0.6*255,0.2*255,0.2*255)
        fg(0.8*255,0.4*255,0.4*255)
        for i=16,200,48 do
            rect('fill',0,i,320,24)
        end

        header_draw('Page 4: Tips')
    end

    header_draw('Left/right to navigate help',200-10)

    while love.timer.getTime()-dt<1/60 do
    end
end

function help_update()
    dt=love.timer.getTime()

    helpscr=helpscr or 1
    if tapped('left')  then helpscr=helpscr-1 end
    if tapped('right') then helpscr=helpscr+1 end
    if helpscr<1 then helpscr=4 end
    if helpscr>4 then helpscr=1 end

    t=t+1
end

love.update=title_update
love.draw=title_draw

DEBUG=false