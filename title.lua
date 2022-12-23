local title_sel={i=1,'Play','Register','Quit'}

function title_msg_draw(title_t)
    for i,c in ipairs(title_sel) do
        local msg=c
        if i==title_sel.i then
            if t%24<8 then
            msg='  '..c..'  '
            elseif t%24<16 then
            msg='> '..c..' <'
            else
            msg=' >'..c..'< '
            end
        end
        if (i-1)*15<title_t then
            local tx=120
            if i==1 then tx=120-25 end
            if i==2 then tx=120-10 end
            fg(0.2*255,0.4*255,0.8*255)
            lg.print(msg,tx-1,200-120+(i-1)*16)
            lg.print(msg,tx+1,200-120+(i-1)*16)
            lg.print(msg,tx,200-120+(i-1)*16-1)
            lg.print(msg,tx,200-120+(i-1)*16+1)
            fg(0.8*255,0.8*255,0.8*255)
            lg.print(msg,tx,200-120+(i-1)*16)
        end
    end
end

function title_select()
    if tapped('right') then title_sel.i=title_sel.i+1 end
    if tapped('left')  then title_sel.i=title_sel.i-1 end
    if tapped('up')    then title_sel.i=title_sel.i-1 end
    if tapped('down')  then title_sel.i=title_sel.i+1 end
    if title_sel.i<1 then title_sel.i=#title_sel end
    if title_sel.i>#title_sel then title_sel.i=1 end
    if tapped('z') then title_lock() end
end

title_x=-160
title_t=nil
function title_anim()
    if title_t then title_t=title_t+1 end
    if title_x<0 then title_x=title_x+3; if title_x>=0 then title_t=0; title_x=0 end end
end

function title_lock()
    local sel=title_sel[title_sel.i]
    if sel=='Play' then love.update=menu_update; love.draw=menu_draw; bullets={} end
    if sel=='Register' then love.update=register_update; love.draw=register_draw end
    if sel=='Quit' then love.event.quit() end
end

function checkerboard_draw()
    fg(0.2*255,0.2*255,0.2*255)
    for x=-1,10-1 do for y=-1,7-1 do
        if (x+y)%2==1 then rect('fill',x*32+t*0.5%32,y*32+t*0.5%32,32,32) end
    end end
end

function shareware_msg_draw()
    local msg='support shareware!'
    local tx=0
    for i=1,#msg do
        local char=sub(msg,i,i)
        fg(0.2*255,0.2*255,0.2*255)
        lg.print(char,320/2-font:getWidth(msg)/2+tx+1,16+6+sin(i*0.2+t*0.1)*8+1)
        fg(0.8*255,0.8*255,0.8*255)
        lg.print(char,320/2-font:getWidth(msg)/2+tx,16+6+sin(i*0.2+t*0.1)*8)
        tx=tx+font:getWidth(char)
    end
end

local register_lines={
    'this is the shareware episode,',
    'containing 8 circuits of 3 attacks.',
    '',
    'you can get 4 additional circuits by going to',
    '>> https://verysoftwares.itch.io/interobg <<',
    'and paying the 2 euro registration fee.',
    '',
    'your support is much appreciated',
    'so i can continue making games.',
    '',
    '',
    '--Leonard Somero (verysoftwares)'
}

function register_msg_draw()
    for i,m in ipairs(register_lines) do
        fg(0.2*255,0.2*255,0.2*255)
        lg.print(m,320/2-font:getWidth(m)/2+1,48+(i-1)*10+6+1)
        if sub(m,1,1)=='>' then
            local tx=0
            for j=1,#m do
                local char=sub(m,j,j)
                fg(160+flr(sin(j*0.2)*(255-160)),160+flr(sin(j*0.2+2*pi/3)*(255-160)),160+flr(sin(j*0.2+2*pi/3*2)*(255-160)))
                lg.print(char,320/2-font:getWidth(m)/2+tx,48+(i-1)*10+6)
                tx=tx+font:getWidth(char)
            end
        else
        fg(0.8*255,0.8*255,0.8*255)
        lg.print(m,320/2-font:getWidth(m)/2,48+(i-1)*10+6)
        end
    end
end