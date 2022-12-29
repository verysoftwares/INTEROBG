local help_page_2={
    'This game consists of 8 "circuits",', 
    'each with 3 attacks (intro, challenge, boss).',
    'Every attack can be slowed down or sped up with Z/X.',
    '',
    'Upon completing a circuit at any playing speed,',
    'you\'ll be rewarded with a white checkmark',
    'in the circuit selection screen.',
    '',
    'There\'s also a green checkmark',
    'for never going below 1.00x speed!',
}

local help_page_3={
    'This game is all about high scoring!',
    '',
    'You get points by "grazing" bullets. This means having',
    'bullets touch the blue rectangle around the player.',
    '',
    '',
    '',
    '',
    '',
    '',
    'Once you\'ve grazed a bullet, a score label appears.',
    'Keep in mind that the points only count when the score label',
    'reaches your current score at the bottom of the screen.',
    '',
    'The point value for each graze is 100 multiplied by your',
    'current playing speed. That means that you\'ll get 50 points',
    'at 0.5x speed, 150 points at 1.5x speed, and so on.'
}

local help_page_4={
    '* If you\'re having trouble with an attack,',
    'try to slow down time with the Z key.',
    '',
    '* Generally, you\'ll want to stay far from the bullet spawners.',
    '',
    '* You don\'t have to complete the circuits in order.',
    '',
    '* A faster playing speed doesn\'t always mean you\'ll get',
    'better scores. Sometimes it\'s worth it to reach',
    'bigger clusters of bullets at a lower speed.',
    '',
    '* Stay cool even when dying. Keyboards are expensive.',
}

function helpscr1()
    bg(0.3*255,0.3*255,0.3*255)
    fg(0.5*255,0.5*255,0.5*255)
    for i=16,200,48 do
        rect('fill',0,i,320,24)
    end

    header_draw('Page 1 of 4: Gameplay elements',0,true)

    local ox,oy=24,16

    fg(0.1*255,0.1*255,0.1*255)
    rect('fill',16+1+ox,16+1-3+oy,32-2,32-2)
    fg(0.4*255,0.8*255,0.4*255)
    rect('line',16+ox,16-3+oy,32,32)
    player_draw(16+8+8-4+1+ox,16+8+8-4+1-3+oy,true)

    local msg='This is you. Arrow keys to move and'
    drop_shadow_print(msg,16+32+4+ox,16+4+oy)
    local msg='Z/X to slow down/speed up time.'
    drop_shadow_print(msg,16+32+4+ox,16+4+10+oy)

    fg(0.1*255,0.1*255,0.1*255)
    rect('fill',16+1+ox,16+1-3+36+oy,32-2,32-2)
    fg(0.4*255,0.8*255,0.4*255)
    rect('line',16+ox,16-3+36+oy,32,32)
    bullet_draw({x=16+8+8-4+1+ox,y=16+8+8-4+1-3+36+oy})

    local msg='This is a bullet. Don\'t touch it, but'
    drop_shadow_print(msg,16+32+4+ox,16+4+36+oy)
    local msg='stay just close enough to gain score.'
    drop_shadow_print(msg,16+32+4+ox,16+4+10+36+oy)

    fg(0.1*255,0.1*255,0.1*255)
    rect('fill',16+1+ox,16+1-3+36+36+oy,32-2,32-2)
    fg(0.4*255,0.8*255,0.4*255)
    rect('line',16+ox,16-3+36+36+oy,32,32)
    local img
    if t%12<4 then img=sparkle1
    elseif t%12<8 then img=sparkle2
    else img=sparkle3 end

    lg.draw(img,16+8+8-4+1-4+ox,16+8+8-4+1-3+36+36-4+oy)

    local msg='This is a bullet spawner.'
    drop_shadow_print(msg,16+32+4+ox,16+4+36+36+5+oy)

    fg(0.1*255,0.1*255,0.1*255)
    rect('fill',16+1+ox,16+1-3+36+36+36+oy,32-2,32-2)
    fg(0.4*255,0.8*255,0.4*255)
    rect('line',16+ox,16-3+36+36+36+oy,32,32)

    fg(0.8*255,0.4*255,0.4*255)
    lg.print('100',16+8+8-4+1-4-1+ox,16+8+8-4+1-3+36+36+36-2+oy)

    local msg='This is a score label. Once it hits the'
    drop_shadow_print(msg,16+32+4+ox,16+4+36+36+36+oy)
    local msg='score counter, you get that many points.'
    drop_shadow_print(msg,16+32+4+ox,16+4+36+36+36+10+oy)
end

function helpscr2()
    bg(0.0*255,0.4*255,0.0*255)
    fg(0.2*255,0.6*255,0.2*255)
    for i=16,200,48 do
        rect('fill',0,i,320,24)
    end

    header_draw('Page 2 of 4: Game progression',0,true)

    for i,v in ipairs(help_page_2) do
    drop_shadow_center_print(v,24+(i-1)*10)
    end

    fg(0.1*255,0.1*255,0.1*255)
    rect('fill',320/2-32-2+1,16+#help_page_2*10+10+1,32-2,32-2)
    fg(0.4*255,0.8*255,0.4*255)
    rect('line',320/2-32-2,16+#help_page_2*10+10,32,32)

    fg(0.1*255,0.1*255,0.1*255)
    rect('fill',320/2+2+1,16+#help_page_2*10+10+1,32-2,32-2)
    fg(0.4*255,0.8*255,0.4*255)
    rect('line',320/2+2,16+#help_page_2*10+10,32,32)

    local cmx,cmy=320/2-32-2+12,16+#help_page_2*10+10+12
    fg(0.1*255,0.1*255,0.1*255)
    rect('fill',cmx,cmy,8,8)
    fg(0.8*255,0.8*255,0.8*255)
    lg.line(cmx+1,cmy-1+4,cmx+4,cmy-1+8-1)
    lg.line(cmx+3,cmy-1+8-1,cmx+6,cmy-1+1)
    lg.line(cmx+1,cmy+4,cmx+4,cmy+8-1)
    lg.line(cmx+3,cmy+8-1,cmx+6,cmy+1)
    rect('line',cmx,cmy,8,8)

    local cmx,cmy=320/2+2+12,16+#help_page_2*10+10+12
    fg(0.1*255,0.1*255,0.1*255)
    rect('fill',cmx,cmy,8,8)
    fg(0.4*255,0.8*255,0.4*255)
    lg.line(cmx+1,cmy-1+4,cmx+4,cmy-1+8-1)
    lg.line(cmx+3,cmy-1+8-1,cmx+6,cmy-1+1)
    lg.line(cmx+1,cmy+4,cmx+4,cmy+8-1)
    lg.line(cmx+3,cmy+8-1,cmx+6,cmy+1)
    rect('line',cmx,cmy,8,8)

    drop_shadow_center_print('Can you beat all 24 attacks?',24+(#help_page_2)*10+32+10)
end

function helpscr3()
    local oy=3
    bg(0.2*255,0.2*255,0.6*255)
    fg(0.4*255,0.4*255,0.8*255)
    for i=16,200,48 do
        rect('fill',0,i,320,24)
    end

    header_draw('Page 3 of 4: Scoring',0,true)

    for i,v in ipairs(help_page_3) do
    drop_shadow_center_print(v,12+(i-1)*10+oy)
    end

    fg(0.1*255,0.1*255,0.1*255)
    rect('fill',320/2-52/2+1,16+3*10+10+1+oy,52-2,52-2)
    fg(0.4*255,0.8*255,0.4*255)
    rect('line',320/2-52/2,16+3*10+10+oy,52,52)

    spec.demo_bullet=spec.demo_bullet or {x=320/2+52/2-8-10,y=16+4*10+1+oy}
    spec.labels=spec.labels or {}

    local px,py=320/2-52/2+1+32-2,16+3*10+10+1+32-2+oy

    if AABB(spec.demo_bullet.x,spec.demo_bullet.y,6,6,px+3-15,py+3-15,30,30) then
        if not spec.demo_bullet.grazed and not spec.demo_bullet.safe then
        ins(spec.labels,{x=spec.demo_bullet.x,y=spec.demo_bullet.y,tonumber(fmt('%.3d',flr(100*tmult+0.5)))})
        spec.demo_bullet.grazed=true
        end
    end
    for i=#spec.labels,1,-1 do
        local l=spec.labels[i]
        l.x=l.x+(320/2+52/2-l.x)*0.01
        l.y=l.y+(16+3*10+10+52+oy-l.y)*0.01
        if l.x+font:getWidth(l[1])>320/2+52/2+1 then
            rem(spec.labels,i)
        end
    end
    spec.demo_bullet.x=spec.demo_bullet.x-0.5
    spec.demo_bullet.y=spec.demo_bullet.y+0.5
    if spec.demo_bullet.x<=320/2-52/2+1+1 then spec.demo_bullet={x=320/2+52/2-8-10,y=16+4*10+1+oy} end
    
    bullet_draw(spec.demo_bullet)

    player_draw(px,py)

    fg(0.8*255,0.4*255,0.4*255)
    for i,l in ipairs(spec.labels) do
        lg.print(fmt('%.3d',l[1]),l.x,l.y)
    end
end

function helpscr4()
    local oy=4
    bg(0.6*255,0.2*255,0.2*255)
    fg(0.8*255,0.4*255,0.4*255)
    for i=16,200,48 do
        rect('fill',0,i,320,24)
    end

    header_draw('Page 4 of 4: Tips',0,true)

    for i,v in ipairs(help_page_4) do
    drop_shadow_center_print(v,36+(i-1)*10+oy)
    end
end