function circuit_select()
    if tapped('right') then circuit=circuit+1; spawn_t=t+1; bullets={} end
    if tapped('left')  then circuit=circuit-1; spawn_t=t+1; bullets={} end
    if tapped('up')    then circuit=circuit-4; spawn_t=t+1; bullets={} end
    if tapped('down')  then circuit=circuit+4; spawn_t=t+1; bullets={} end
    if circuit<1 then circuit=circuit+8 end
    if circuit>8 then circuit=circuit-8 end
    if tapped('z') then circuit_lock() end
end

function circuit_lock()
    love.update=main_update
    love.draw=main_draw
    tapz=true

    stage=1+(circuit-1)*3

    bullets={}
    
    score=0
    shown_score=0

    t=0
    tmult=1
    timer=15*60
    spawn_t=0

    x=160+30*2*cos(pi/2)
    y=100+30*2*sin(pi/2)

    if circuit==1 then
        bullets={{10*2,120},{20*2,160},{40*2,180}}
        rtutor=nil; ltutor=nil; dtutor=nil; ututor=nil; ftutor=nil; pgshow=nil; pgututor=nil; pgdtutor=nil
        stage1() -- to initialize bullet x,y
    end

    if DEBUG then bullets={}; stage=13 end
end

function circuit_preview()
    if circuit==1 then
        stage2()
    elseif circuit==2 then
        stage4()
    elseif circuit==3 then
        stage7()
    elseif circuit==4 then
        stage11()
    elseif circuit==5 then
        stage14()
    end
    
    local bx,by=(60+12)*(circuit-1),16+8-2
    if circuit>4 then bx=(60+12)*((circuit-4)-1) end
    
    for i=#bullets,1,-1 do
        local b=bullets[i]
        b.x=b.x+b.dx; b.y=b.y+b.dy
        if b.x/6+24+2+bx<20+bx+1+2 or b.y/6+39-2<by+1 or b.x/6+24+2+bx>20+bx+60-1+2 or b.y/6+39-2>by+50-1 then
            rem(bullets,i)
        end
    end
end

function menu_header_draw()
    fg(0.4*255,0.8*255,0.4*255)
    rect('fill',0,0,320,10)
    fg(0.1*255,0.1*255,0.1*255)
    lg.print('select circuit?! arrows and Z?!',320/2-font:getWidth('select circuit?! arrows and Z?!')/2+sin(t*0.004*8.8)*24,1)
end

function rect_draw(i)
    -- upper row
    fg(0.4*255,0.8*255,0.4*255)
    if i+1==circuit then 
        if t%8<4 then fg(0.8*255,0.8*255,0.8*255)
        else fg(0.8*255,0.4*255,0.4*255) end
    end
    rect('line',20+(60+12)*i+2,16+8-2,60,50)
    
    -- lower row
    fg(0.4*255,0.8*255,0.4*255)
    if i+1+4==circuit then 
        if t%8<4 then fg(0.8*255,0.8*255,0.8*255)
        else fg(0.8*255,0.4*255,0.4*255) end
    end
    rect('line',20+(60+12)*i+2,16+8-2+50+36,60,50)
end

function hiscore_draw(i)
    -- upper row
    fg(0.8*255,0.4*255,0.4*255)
    lg.print(fmt('high:',0),20+(60+12)*i+2,16+8-2+50+1)
    fg(0.7*255,0.3*255,0.3*255)
    lg.print(fmt('%.9d',hiscores[i+1]),20+(60+12)*i+2,16+8-2+50+1+8)
    fg(0.6*255,0.2*255,0.2*255)
    lg.print(fmt('last:'),20+(60+12)*i+2,16+8-2+50+1+8+8)
    fg(0.5*255,0.1*255,0.1*255)
    lg.print(fmt('%.9d',lastscores[i+1]),20+(60+12)*i+2,16+8-2+50+1+8+8+8)

    -- lower row
    fg(0.8*255,0.4*255,0.4*255)
    lg.print(fmt('high:',0),20+(60+12)*i+2,16+8-2+50+36+50+1)
    fg(0.7*255,0.3*255,0.3*255)
    lg.print(fmt('%.9d',hiscores[i+1+4]),20+(60+12)*i+2,16+8-2+50+36+50+1+8)
    fg(0.6*255,0.2*255,0.2*255)
    lg.print(fmt('last:'),20+(60+12)*i+2,16+8-2+50+36+50+1+8+8)
    fg(0.5*255,0.1*255,0.1*255)
    lg.print(fmt('%.9d',lastscores[i+1+4]),20+(60+12)*i+2,16+8-2+50+36+50+1+8+8+8)
end

function number_draw(i)
    fg(0.8*255,0.8*255,0.8*255)

    local nx=20+(60+12)*i+2+20-4+8+3
    local ny=16+8-2+50-30-10+12-1
    if i+1~=circuit then lg.print(i+1,nx,ny) end
    if i+1+4==5 and i+1+4~=circuit then ny=ny+50+36; lg.print(i+4+1,nx,ny) end

    if i+1+4>=6 then
        lg.print('not\nin\ndemo',20+(60+12)*i+2+20-4,16+8-2+50+36+50-30-10)
    end
end

function thumbnail_draw()
    fg(0.4*255,0.8*255,0.4*255)
    local bx,by=(60+12)*(circuit-1),0
    if circuit>4 then bx=(60+12)*((circuit-4)-1) end
    if circuit>4 then by=by+50+36 end
    for i,r in ipairs(bullets) do
        lg.point(r.x/6+24+2+bx,r.y/6+39-2+by)
    end
end