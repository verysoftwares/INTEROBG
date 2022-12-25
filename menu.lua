function circuit_select()
    if tapped('right') then circuit=circuit+1; spawn_t=t+1; bullets={}; spec={} end
    if tapped('left')  then circuit=circuit-1; spawn_t=t+1; bullets={}; spec={} end
    if tapped('up')    then circuit=circuit-4; spawn_t=t+1; bullets={}; spec={} end
    if tapped('down')  then circuit=circuit+4; spawn_t=t+1; bullets={}; spec={} end
    if circuit<1 then circuit=circuit+8 end
    if circuit>8 then circuit=circuit-8 end
    if tapped('z') then tapz=true; circuit_lock() end
    if tapped('return') then circuit_lock() end
end

function circuit_lock()
    love.update=main_update
    love.draw=main_draw

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

    spec={}

    red_check=true

    if circuit==1 then
        bullets={{10*2,120},{20*2,160},{40*2,180}}
        rtutor=nil; ltutor=nil; dtutor=nil; ututor=nil; ftutor=nil; pgshow=nil; pgututor=nil; pgdtutor=nil
        stage1() -- to initialize bullet x,y
    end

    if DEBUG then 
        bullets={}
        --[[stage=18
        spec.pb={}
        for i=0,360-1,3 do
            local a=i*pi/180
            ins(bullets,{r=90,a=a,bt=t,dx=0,dy=0})
            ins(spec.pb,bullets[#bullets])
        end 
        stage18()]]
        stage=24
    end
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
    elseif circuit==6 then
        stage16()
    elseif circuit==7 then
        stage20()
    elseif circuit==8 then
        stage24()
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
    lg.print('select circuit?!',320/2-font:getWidth('select circuit?! arrows and Z?!')/2+sin(t*0.004*8.8)*24,0)

    fg(0.8*255,0.8*255,0.8*255)
    local swmsg='Shareware version - please distribute'
    lg.print(swmsg,320/2-font:getWidth(swmsg)/2,200-8-3)
end

function rect_draw(i)
    -- upper row
    fg(0.4*255,0.8*255,0.4*255)
    if i+1==circuit then 
        if t%8<4 then fg(0.8*255,0.8*255,0.8*255)
        else fg(0.8*255,0.4*255,0.4*255) end
    end
    rect('line',20+(60+12)*i+2,16+8-2-6,60,50)
    
    -- lower row
    fg(0.4*255,0.8*255,0.4*255)
    if i+1+4==circuit then 
        if t%8<4 then fg(0.8*255,0.8*255,0.8*255)
        else fg(0.8*255,0.4*255,0.4*255) end
    end
    rect('line',20+(60+12)*i+2,16+8-2+50+36-6,60,50)

    -- white & green checkmarks
    for j=0,1 do
    if progress[i+1+j*4]>=1 then
    for k=1,progress[i+1+j*4] do
    local cmx,cmy=20+(60+12)*i+2+60-8-1,16+8-2+50-8-1-6
    if progress[i+1+j*4]==2 and k==1 then cmx=cmx-8 end
    fg(0.1*255,0.1*255,0.1*255)
    rect('fill',cmx,cmy+j*(50+36),8,8)
    fg(0.8*255,0.8*255,0.8*255)
    if k==2 then fg(0.4*255,0.8*255,0.4*255) end
    lg.line(cmx+1,cmy-1+j*(50+36)+4,cmx+4,cmy-1+j*(50+36)+8-1)
    lg.line(cmx+3,cmy-1+j*(50+36)+8-1,cmx+6,cmy-1+j*(50+36)+1)
    lg.line(cmx+1,cmy+j*(50+36)+4,cmx+4,cmy+j*(50+36)+8-1)
    lg.line(cmx+3,cmy+j*(50+36)+8-1,cmx+6,cmy+j*(50+36)+1)
    rect('line',cmx,cmy+j*(50+36),8,8)
    end
    end
    end
end

function hiscore_draw(i)
    -- upper row
    fg(0.8*255,0.4*255,0.4*255)
    lg.print(fmt('high:',0),20+(60+12)*i+2,16+8-2+50+1-6)
    fg(0.7*255,0.3*255,0.3*255)
    lg.print(fmt('%.9d',hiscores[i+1]),20+(60+12)*i+2,16+8-2+50+1+8-6)
    fg(0.6*255,0.2*255,0.2*255)
    lg.print(fmt('last:'),20+(60+12)*i+2,16+8-2+50+1+8+8-6)
    fg(0.5*255,0.1*255,0.1*255)
    lg.print(fmt('%.9d',lastscores[i+1]),20+(60+12)*i+2,16+8-2+50+1+8+8+8-6)

    -- lower row
    fg(0.8*255,0.4*255,0.4*255)
    lg.print(fmt('high:',0),20+(60+12)*i+2,16+8-2+50+36+50+1-6)
    fg(0.7*255,0.3*255,0.3*255)
    lg.print(fmt('%.9d',hiscores[i+1+4]),20+(60+12)*i+2,16+8-2+50+36+50+1+8-6)
    fg(0.6*255,0.2*255,0.2*255)
    lg.print(fmt('last:'),20+(60+12)*i+2,16+8-2+50+36+50+1+8+8-6)
    fg(0.5*255,0.1*255,0.1*255)
    lg.print(fmt('%.9d',lastscores[i+1+4]),20+(60+12)*i+2,16+8-2+50+36+50+1+8+8+8-6)
end

local circuit_titles={
    'Tutorial',
    'Curves',
    'Doubles',
    'Homing',
    'Shapes',
    'Trap',
    'Butterfly',
    'Brutal'
}

function number_draw(i)
    fg(0.8*255,0.8*255,0.8*255)

    local nx=20+(60+12)*i+2+20-4+8+3
    local ny=16+8-2+50-30-10+12-1-4-2-6
    if i+1~=circuit then lg.print(i+1,nx+4-font:getWidth(i+1)/2,ny); lg.print(circuit_titles[i+1],nx+4-font:getWidth(circuit_titles[i+1])/2,ny+12) end
    if i+1+4~=circuit then ny=ny+50+36; lg.print(i+4+1,nx+4-font:getWidth(i+4+1)/2,ny); lg.print(circuit_titles[i+4+1],nx+4-font:getWidth(circuit_titles[i+4+1])/2,ny+12) end

    --[[if i+1+4==8 then
        lg.print('not\nin\ndemo',20+(60+12)*i+2+20-4,16+8-2+50+36+50-30-10)
    end]]
end

function thumbnail_draw()
    fg(0.4*255,0.8*255,0.4*255)
    local bx,by=(60+12)*(circuit-1),-6
    if circuit>4 then bx=(60+12)*((circuit-4)-1) end
    if circuit>4 then by=by+50+36 end
    for i,r in ipairs(bullets) do
        lg.point(r.x/6+24+2+bx,r.y/6+39-2+by)
    end
end